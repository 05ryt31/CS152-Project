# Model, finetuning, and fallback (Issue #13)

Status: **decided (Oct 16).** Base model Qwen2.5-Coder-7B-Instruct, QLoRA on Rosetta Code pairs, adapter on
Ryuto's Hugging Face account, Colab Pro cap USD 10-12 / month, #31 compares 1.5B vs 7B.

## Decision summary

| Item | Choice | Why |
|---|---|---|
| Base model | **Qwen2.5-Coder-7B-Instruct** (Apache 2.0, dense 7B) | Open weights, strong multi-language code pretraining that includes Haskell, Scheme and Prolog, fits QLoRA on a free Colab T4 |
| Dev model | Qwen2.5-Coder-1.5B-Instruct | Same family, minutes per run; use for pipeline/prompt debugging only, never for reported numbers |
| Finetuning | QLoRA (4-bit base, LoRA rank 16 on attention + MLP) via Unsloth + TRL `SFTTrainer` | Fits 15 GB VRAM; adapter is a few hundred MB and versionable |
| Compute | Google Colab free tier (T4, 15 GB) first; Colab Pro only if free quota blocks us | Zero cost; adapter checkpoints saved to Drive every N steps because sessions cap at 12 h |
| Training data | Rosetta Code task pairs (same task, language A → language B), restricted to our six languages | Only public corpus with substantial Prolog, Scheme and Haskell solutions of the same tasks; 16,742 ordered pairs available (counted Oct 15, below) |
| Inference | Same base + adapter via `transformers` (or vLLM) on Colab; greedy decoding | One code path for finetuned and fallback runs |
| Fallback | Base Qwen2.5-Coder-7B-Instruct + fixed 3-shot prompt, no adapter | Decided on **Oct 31** by the go/no-go below |
| Stretch (#31) | Qwen2.5-Coder-1.5B-Instruct with the same adapter recipe (decided Oct 16: 1.5B vs 7B, to stay within budget) | Size comparison promised in the proposal "if time permits" |

Exact model revisions (Hugging Face commit hashes) are in `pipeline/model.lock.json`. Hugging Face account `05ryt31` created Oct 16.
Verified Oct 16 via the Hub API: both the 7B and 1.5B Instruct weights are `apache-2.0` and ungated; revisions are pinned in `pipeline/model.lock.json`.

## 1. Base model candidates

| Model | Params | License | QLoRA on T4? | Notes |
|---|---|---|---|---|
| Qwen2.5-Coder-7B-Instruct | 7B dense | Apache 2.0 | Yes (~6-8 GB) | **Recommended.** Code-specialized, 92 languages in pretraining incl. Haskell, Scheme, Prolog |
| Qwen2.5-Coder-1.5B-Instruct | 1.5B dense | Apache 2.0 | Yes | Dev/debug model, also a cheap second size for #31 |
| Qwen3-Coder-30B-A3B | 30B MoE, 3B active | Apache 2.0 | No (weights ~60 GB) | Stronger, but inference does not fit free compute; candidate only with paid GPU |
| Gemma 4 (small sizes) | varies | Apache 2.0 (Apr 2026 release) | Likely | General model, not code-specialized; weaker prior on Prolog/Scheme expected |
| DeepSeek-Coder-V2-Lite | 16B MoE, 2.4B active | DeepSeek license | Marginal | Good code model, license is not OSI-approved; skip |
| API model (Claude / GPT) | n/a | n/a | cannot finetune | Not a candidate for the main study (proposal says finetuned); optional upper-bound reference in #31 |

Why a 7B dense model and not the best available: the research question is about paradigm transfer
*relative* across language pairs under one fixed model, not about absolute quality. A model small enough that
we can finetune and run the full matrix ourselves is worth more than a stronger model we cannot control.

## 2. Finetuning recipe

- **Method**: QLoRA. Base loaded in 4-bit NF4, LoRA rank 16, alpha 32, dropout 0.05, targets
  `q_proj,k_proj,v_proj,o_proj,gate_proj,up_proj,down_proj`.
- **Framework**: Unsloth (memory/speed) on top of Hugging Face `transformers`, `peft`, `trl`.
- **Format**: chat SFT. System + user = the exact migration prompt template from `pipeline/prompts/v1.md`
  with the source program filled in; assistant = the target program in a fenced block. Training on the same
  template we evaluate with is deliberate.
- **Hyperparameters (starting point)**: max sequence 2048 tokens, effective batch 16 (micro-batch 2 x grad
  accumulation 8), learning rate 2e-4 cosine, 2 epochs, gradient checkpointing on. Adjust only if loss does
  not fall or we OOM.
- **Budget**: target 2,000-5,000 pairs → roughly 1-3 h on a T4 with Unsloth. Checkpoint to Drive every 100 steps.
- **Artifacts**: adapter pushed to the Hugging Face Hub as `05ryt31/lost-across-paradigms` (Ryuto's account) and tagged; `pipeline/model.lock.json`
  records base revision, adapter commit, and the training config hash.

## 3. Training data

**Primary: Rosetta Code.** Each Rosetta task has solutions in many languages, so (task, lang A, lang B) gives a
natural translation pair without any LLM in the loop. The `christopher/rosetta-code` dataset on Hugging Face
is a crawl of the site (GFDL license; attribution required in the report).

Construction steps:

1. Filter to our six languages (Python, JavaScript, Java, Scheme, Haskell, Prolog). Keep one solution per
   task per language (the first, or the shortest that is not a stub).
2. Keep tasks that have solutions in at least two of our languages; emit every ordered pair
   (A → B) with A ≠ B. Measured on `christopher/rosetta-code` (79,013 rows, Oct 15, 2026,
   `pipeline/data/rosetta_stats.py`): 1,100 tasks have ≥ 2 of our languages, 236 have all six, and the ordered
   pairs total 16,742. Scheme and Prolog are the thin ends but still comfortably above the ~300-per-target floor,
   so **balance by target language** (cap each target at ~1,500 pairs) rather than oversample.

   | Language | Solutions | Tasks shared with ≥1 other (as target) | Median lines |
   |---|---|---|---|
   | Python | 1,139 | 3,531 | 23 |
   | Java | 1,004 | 3,400 | 38 |
   | Haskell | 1,023 | 3,420 | 20 |
   | JavaScript | 702 | 2,741 | 24 |
   | Prolog | 434 | 1,877 | 24 |
   | Scheme | 397 | 1,773 | 16 |

   Shared-task matrix (src → tgt): Python→Haskell 1,010, Python→Java 995, Java→Haskell 932, Python→Prolog 431,
   Java→Prolog 419, Haskell→Prolog 422, Scheme→Prolog 254 (the smallest cell). Label notes: use exactly
   `Python`, `JavaScript`, `Java`, `Scheme`, `Haskell`, `Prolog` (plus lowercase variants); exclude `Visual Prolog`,
   `Lambda Prolog`, `JavaScript + HTML/SVG`, `Python+SQLite`. `Racket` is a separate label (not merged into Scheme
   because our harness runs Chicken Scheme). One row per task-language; a row may concatenate several variants
   of a solution, so step 3 also splits on Rosetta's `===` sub-headers if present and keeps the first.
3. Drop solutions over 150 lines or under 3 lines, and any solution containing I/O that is not stdin/stdout.
4. **Leakage check**: remove every Rosetta task whose title or description overlaps a benchmark problem
   (string match on title words plus a manual pass over the 15-20 benchmark names). Record the removed list in
   `pipeline/data/excluded_tasks.txt`. Hold out 5 % of the remaining tasks (by task, not by pair) as a dev set.
5. Save as `pipeline/data/train.jsonl`, `dev.jsonl` with fields `task, src_lang, tgt_lang, src_code, tgt_code`.

Secondary sources, only if Rosetta is too thin: MultiPL-E (HumanEval/MBPP in 18+ languages, but **no Haskell or
Prolog**) and CodeTransOcean (multilingual translation benchmark). Neither covers the logic paradigm, so they can
at most strengthen the imperative/OO/functional pairs. We do **not** generate training pairs with a larger LLM:
that would make the finetuned model's paradigm knowledge a copy of another model's, which confounds RQ2.

## 4. Held constant across every run

| Setting | Value |
|---|---|
| Base model + revision | pinned in `model.lock.json` |
| Adapter commit | pinned (or `none` for the fallback) |
| Prompt | `pipeline/prompts/v1.md`, hash recorded per output |
| Decoding | greedy (temperature 0), `max_new_tokens` 2048, no sampling, seed 0 |
| Code extraction | first fenced block whose tag matches the target language; otherwise the whole response, flagged `no_fence` |
| Retries | none; a truncated or empty output is a recorded failure |

Any change to this table is a new `run_id`, and the intra-paradigm pairs are re-run under the new id.

## 5. Fallback plan and go/no-go (Oct 31)

The finetuned model is **GO** only if all three hold on Oct 31:

1. The adapter trains to completion on Colab without OOM and the dev loss falls below the first-epoch value.
2. On a held-out set of 20 Rosetta tasks (not in training), harness pass rate of base + adapter is **≥** the
   base model with the 3-shot prompt, for both a functional and the Prolog target.
3. The full migration matrix (problems × pairs) can be generated in **under 8 GPU-hours** at our settings.

If any fails: **NO-GO**, switch to the fallback = base Qwen2.5-Coder-7B-Instruct with a fixed 3-shot prompt
(the same three examples for every pair, chosen from Rosetta and listed in `prompts/v1-fewshot.md`). The report
states the switch and the reason. Fallback runs use the same pipeline; only `adapter: none` changes.

Either way, the model used for the final matrix is frozen on Nov 2 and the intra-paradigm pairs from M2 are
re-run under it so the whole matrix shares one model.

## 6. Open decisions

- [x] Base model: Qwen2.5-Coder-7B-Instruct, dense 7B (decided Oct 15)
- [x] Hugging Face: adapter lives at `05ryt31/lost-across-paradigms`, Ryuto owns the account (decided Oct 16)
- [x] Colab Pro budget cap: USD 10-12 / month on one account, only if the free quota throttles us (decided Oct 16)
- [x] #31 compares 1.5B vs 7B to stay within budget (decided Oct 16)
- [x] Rosetta coverage counted (Oct 15): 1,877 pairs into Prolog, 1,773 into Scheme; no oversampling needed

## Sources consulted (Oct 15, 2026)

- Rosetta Code crawl on Hugging Face: [christopher/rosetta-code](https://huggingface.co/datasets/christopher/rosetta-code) (GFDL)
- Colab free T4 with QLoRA/Unsloth: [Unsloth fine-tuning guide](https://machinelearningplus.com/gen-ai/unsloth-fine-tuning/),
  [Colab GPU limits](https://www.hivenet.com/post/google-colaboratory-gpu-complete-guide-to-free-cloud-gpu-access-and-limitations)
- 2026 fine-tuning landscape (Gemma 4, Qwen 3.x, LoRA/QLoRA guidance): [LoRA/QLoRA guide 2026](https://www.kunalganglani.com/blog/fine-tune-open-source-llm-lora-qlora.md),
  [Best LLM for fine-tuning](https://www.ertas.ai/best/best-llm-for-fine-tuning)
- Model cards to verify before pinning: Qwen2.5-Coder-7B-Instruct and 1.5B-Instruct on the Hugging Face Hub
