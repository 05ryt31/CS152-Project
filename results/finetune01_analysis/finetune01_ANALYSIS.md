# Analysis of run finetune01

## Common failure sources

- The most common source of failure was the LLM refusing to obey the prompts. It frequently hardcoded its own test cases, rather than taking them in through stdin.
- Another common source of failure was the LLM adding additional information or otherwise not adhering to the code it was given. For example, it interpreted many implementations of `p02_merge_sorted` as *merge sort*, instead of *merge two sorted lists*.
- Many implementations included the injection of a unicode character, which was perhaps present in the fine tuning data, that prevented compilation.

## General observations

- Idiomaticity was very high for all translated code. Most programs were well-documented and clearly structured.
- Translated code all became similar in style and quality, regardless of the source language. For example, `p01_rle`, when translated into Python, produced virtually identical programs. This is in contrast with the base run, where the style of the source language was frequently injected into code of the target language.
- Cross-language hallucination rates dropped significantly from the base run. For example, no translations from Haskell included `foldl`, unlike in the base run. However, hallucinations specific to the translated language, such as incorrect function names or import statements, remained.
- The LLM sometimes became stuck in loops of adding test cases or unnecessary code, causing its production to terminate early. For example, in `p05_expr_tree`, Python -> Prolog, the same predicate was repeated dozens of times, until it terminated suddenly.

## Language specific

### Java

- Generally idiomatic, regardless of source language.
- None of the programs used the Java package given, resulting in instant crashes in the test harness.
- Functions were smaller and more cleanly broken up than in the base run.

### JavaScript

- Generally idiomatic, regardless of source language.
- Some `p14_bfs` translations resulted in infinite loops.

### Prolog

- Generally idiomatic, regardless of source language.
- Mutability was rarely used, even in state problems.
- Unlike in the base run, no translations out of Prolog retained Prolog-specific naming conventions.

### Haskell

- Generally idiomatic, regardless of source language.
- Unlike in the base run, some translations were missing type signatures.
- State mutation was rarely used, even when translating from an imperative/OO language.

### Scheme

- Generally idiomatic, regardless of source language.
- Unnecessary state mutation was still an issue, as it was in the base run. However, it appears less often in this run.
- Translations from Haskell were no less idiomatic than from other languages.

### Python

- Generally idiomatic, regardless of source language.
- Several translations included a simulation of the console, instead of actual code. This is especially evident in `p03_dedupe`.
- The high success rate of Python present in the base run has mostly disappeared: translations both to and from Python were slightly less idiomatic and less correct.
- The LLM became better at importing necessary libraries. In the base run, for example, `import re` was often missing when regexes were used; in the fine tuned run, it was almost never missing.
- `p12_group_by`, Scheme -> Python, hallucinated the problem to be about grouping by ages.


