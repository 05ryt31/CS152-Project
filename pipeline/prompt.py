"""Load the frozen prompt template (prompts/v1.md), fill it, and extract code from a reply."""
from __future__ import annotations

import hashlib
import re
from dataclasses import dataclass
from pathlib import Path

FENCE_ALIASES = {"py": "python", "js": "javascript", "hs": "haskell", "scm": "scheme", "pl": "prolog"}
_PLACEHOLDER = re.compile(r"\{\{(\w+)\}\}")
_FENCE_LINE = re.compile(r"^(`{3,})\s*$")


@dataclass(frozen=True)
class Template:
    version: str
    sha256: str
    system: str
    user: str
    rules: dict[str, str]  # language id -> target rules block


def load_template(path: Path) -> Template:
    text = path.read_text()
    rules_section = _section(text, "## Target rules")
    rules = {}
    for heading in re.findall(r"^### (\w+)\s*$", rules_section, flags=re.M):
        rules[heading.lower()] = _fenced(_section(rules_section, f"### {heading}"))
    return Template(
        version=path.stem,
        sha256=hashlib.sha256(text.encode()).hexdigest(),
        system=_fenced(_section(text, "## System")),
        user=_fenced(_section(text, "## User")),
        rules=rules,
    )


def _section(text: str, heading: str) -> str:
    """Text after `heading` up to the next heading of the same or higher level."""
    level = heading.split(" ")[0]
    lines = text.splitlines()
    try:
        start = next(i for i, line in enumerate(lines) if line.strip() == heading)
    except StopIteration:
        raise ValueError(f"heading not found in template: {heading}") from None
    body = []
    for line in lines[start + 1:]:
        if re.match(rf"^#{{1,{len(level)}}} ", line):
            break
        body.append(line)
    return "\n".join(body)


def _fenced(section: str) -> str:
    """Content of the first fenced block; the closing fence must match the opening one."""
    lines = section.splitlines()
    for i, line in enumerate(lines):
        m = _FENCE_LINE.match(line)
        if m:
            fence = m.group(1)
            for j in range(i + 1, len(lines)):
                if lines[j].rstrip() == fence:
                    return "\n".join(lines[i + 1:j]).strip("\n")
            raise ValueError("unterminated fence in template section")
    raise ValueError("no fenced block in template section")


def fill(text: str, fields: dict[str, str]) -> str:
    out = _PLACEHOLDER.sub(lambda m: fields.get(m.group(1), m.group(0)), text)
    leftover = _PLACEHOLDER.findall(out)
    if leftover:
        raise KeyError(f"unfilled placeholders: {sorted(set(leftover))}")
    return out


def build_messages(template: Template, tgt: str, fields: dict[str, str]) -> tuple[str, str]:
    """Return (system, user) with every placeholder filled, target rules included."""
    rules = fill(template.rules[tgt], fields)
    return fill(template.system, fields), fill(template.user, {**fields, "target_rules": rules})


def extract_code(reply: str, fence: str) -> tuple[str, str]:
    """Apply the extraction rule from v1.md. Returns (code, how)."""
    blocks = re.findall(r"^[ \t]*```([^\n`]*)\n(.*?)^[ \t]*```[ \t]*$", reply, flags=re.M | re.S)
    want = FENCE_ALIASES.get(fence, fence).lower()
    for tag, body in blocks:
        tag = tag.strip().lower()
        if FENCE_ALIASES.get(tag, tag) == want:
            return body.rstrip("\n") + "\n", "tagged_fence"
    if blocks:
        return blocks[0][1].rstrip("\n") + "\n", "untagged_fence"
    return reply.rstrip("\n") + "\n", "no_fence"


def to_java_class(problem_id: str) -> str:
    return "".join(part[:1].upper() + part[1:] for part in re.split(r"[^A-Za-z0-9]+", problem_id) if part)


def to_package(parts: list[str]) -> str:
    """Java package from path segments: `-` becomes `_`, every segment must then be an identifier."""
    segs = [p.replace("-", "_") for p in parts]
    bad = [s for s in segs if not re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", s)]
    if bad:
        raise ValueError(f"path segments are not valid Java package names: {bad}")
    return ".".join(segs)
