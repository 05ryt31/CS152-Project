"""Model backends. All of them take (system, user) and return a Reply; decoding is fixed by model.lock.json."""
from __future__ import annotations

import json
import os
import urllib.error
import urllib.request
from dataclasses import dataclass, field


@dataclass
class Reply:
    text: str
    model: str
    usage: dict = field(default_factory=dict)  # prompt_tokens / completion_tokens when the backend reports them


class DryBackend:
    """No model call. Returns an untagged fence so the whole pipeline (prompt, extraction, files) can be exercised."""

    name = "dry"

    def generate(self, system: str, user: str) -> Reply:
        return Reply(text="```\n# dry run: no model was called\n```\n", model="dry")


class HttpBackend:
    """Any OpenAI-compatible /v1/chat/completions server: vLLM, Ollama, llama.cpp. Standard library only."""

    name = "http"

    def __init__(self, base_url: str, model: str, decoding: dict, api_key: str | None = None, timeout: int = 600):
        self.base_url = base_url.rstrip("/")
        self.model = model
        self.decoding = decoding
        self.api_key = api_key or os.environ.get("PIPELINE_API_KEY")
        self.timeout = timeout

    def generate(self, system: str, user: str) -> Reply:
        body = {
            "model": self.model,
            "messages": [{"role": "system", "content": system}, {"role": "user", "content": user}],
            "temperature": self.decoding["temperature"],
            "max_tokens": self.decoding["max_new_tokens"],
            "seed": self.decoding["seed"],
        }
        req = urllib.request.Request(
            f"{self.base_url}/v1/chat/completions",
            data=json.dumps(body).encode(),
            headers={"Content-Type": "application/json", **({"Authorization": f"Bearer {self.api_key}"} if self.api_key else {})},
        )
        with urllib.request.urlopen(req, timeout=self.timeout) as resp:
            data = json.load(resp)
        return Reply(
            text=data["choices"][0]["message"]["content"],
            model=data.get("model", self.model),
            usage=data.get("usage", {}),
        )


class HFBackend:
    """transformers + optional PEFT adapter, loaded at the pinned revisions. Imports lazily so the rest needs no torch."""

    name = "hf"

    def __init__(self, repo: str, revision: str, decoding: dict, adapter: str | None = None,
                 adapter_revision: str | None = None, load_4bit: bool = False):
        import torch
        from transformers import AutoModelForCausalLM, AutoTokenizer

        kwargs = {"revision": revision, "device_map": "auto"}
        if load_4bit:  # 7B in NF4 is ~5.5 GB, fits a Colab T4; the QLoRA adapter is trained on this same 4-bit base
            from transformers import BitsAndBytesConfig

            kwargs["quantization_config"] = BitsAndBytesConfig(
                load_in_4bit=True, bnb_4bit_quant_type="nf4", bnb_4bit_compute_dtype=torch.float16)
        else:
            kwargs["torch_dtype"] = "auto"
        self.tokenizer = AutoTokenizer.from_pretrained(repo, revision=revision)
        self.model = AutoModelForCausalLM.from_pretrained(repo, **kwargs)
        self.model_id = f"{repo}@{revision[:12]}" + ("+nf4" if load_4bit else "")
        if adapter:
            from peft import PeftModel

            self.model = PeftModel.from_pretrained(self.model, adapter, revision=adapter_revision)
            self.model_id += f"+{adapter}@{(adapter_revision or 'main')[:12]}"
        self.decoding = decoding
        torch.manual_seed(decoding["seed"])

    def generate(self, system: str, user: str) -> Reply:
        messages = [{"role": "system", "content": system}, {"role": "user", "content": user}]
        # return_dict=True gives the same mapping on transformers 4.x and 5.x (5.x changed the bare default)
        encoded = self.tokenizer.apply_chat_template(
            messages, add_generation_prompt=True, return_tensors="pt", return_dict=True)
        input_ids = encoded["input_ids"].to(self.model.device)
        out = self.model.generate(input_ids, max_new_tokens=self.decoding["max_new_tokens"], do_sample=False)
        new_tokens = out[0][input_ids.shape[1]:]
        return Reply(
            text=self.tokenizer.decode(new_tokens, skip_special_tokens=True),
            model=self.model_id,
            usage={"prompt_tokens": int(input_ids.shape[1]), "completion_tokens": int(new_tokens.shape[0])},
        )


def make_backend(kind: str, lock: dict, base_url: str | None, model_override: str | None, use_adapter: bool,
                 load_4bit: bool = False):
    decoding = lock["decoding"]
    if kind == "dry":
        return DryBackend()
    if kind == "http":
        if not base_url:
            raise SystemExit("--base-url is required for the http backend (e.g. http://localhost:11434 for Ollama)")
        return HttpBackend(base_url, model_override or lock["base"]["repo"], decoding)
    if kind == "hf":
        base = lock["base"]
        adapter = lock["adapter"] if use_adapter else None
        return HFBackend(
            base["repo"],
            base["revision"],
            decoding,
            adapter=adapter["repo"] if adapter else None,
            adapter_revision=adapter["revision"] if adapter else None,
            load_4bit=load_4bit,
        )
    raise SystemExit(f"unknown backend: {kind}")
