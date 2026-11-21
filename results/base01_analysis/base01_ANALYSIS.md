# Analysis of run base01

## Common failure sources

- A common source of failure was hallucinations of variables or functions. Most hallucinations occurred between paradigms and involved injecting keywords from the source language into the target language. For example, several translations out of Haskell included `foldl`.
- Some implementations forgot to import necessary libraries (i.e. p02_merge_sorted, Python -> Scheme uses `string-split` without importing the library that contains it).
- Some implementations misused functions, causing crashes.

## General observations

- Translations were often substantially longer than was necessary to complete the problem. The LLM frequently introduced additional, unnecessary code for processing or printing types and values.
- Translations within paradigms were less likely to introduce unnecessary code and more likely to opt for the elegant solution. Translations from Python to other imperative languages tended to demonstrate this the best.
- Translations from non-imperative to imperative languages were likely to adopt state-based approaches without issue. In contrast, translations from imperative to non-imperative languages were likely to continue using state-based approaches, even when these approaches were not appropriate in the target language.
- In general, programs translated into imperative languages performed the best.
- Translations from Prolog were most likely to include hallucinations. For example, p02 `Prolog -> Java` included checking for `end_of_file`, despite `end_of_file` being a Prolog construct and nonexistent in Java.
- Translations occasionally included hallucinations unrelated to either language. For example, p15 `Scheme -> JavaScript` defined the function `generate`, but tried to call a function called `generatePermutations`, which does not exist.
- p15 `Python -> Haskell` included a comment from the LLM stating that a line is incorrect. It did not fix this issue, and left both the incorrect line and the comment in the code.

## Language specific

### Java

- `lambda` and `recursion` are often abused when translated from non-imperative languages.
- Non-imperative languages tend to try to replicate non-imperative structures (i.e. streams).
- Translations from non-imperative languages were more likely to avoid using well-defined typing and instead rely on generic `Object`.
- Java struggled the most out of the three target imperative languages. This is likely because Java is less functional than Python and JavaScript, resulting in failures when functional constructs were injected into Java programs.

### JavaScript

- Generally idiomatic, regardless of source language.
- Translations from non-imperative languages tended to use functional strategies; translations from other imperative languages tended to use imperative strategies.
- Likely retained idiomaticity because JavaScript is idiomatic in both functional and imperative styles.

### Prolog

- Generally idiomatic, regardless of source language.
- Translations from imperative languages (especially Java) tended to introduce excessive if/else clauses or use `assert`/`retract`.
- Translations from/to functional languages tended to be relatively successful, especially in comparison to imperative translations.

### Haskell

- Generally idiomatic, regardless of source language.
- Translations from imperative languages (especially Java) tended to introduce excessive if/else clauses or use case when pattern matching was appropriate.
- Few translations used mutability. When mutability was introduced, it was usually in the state problems.
- Type signatures were always included and were always accurate.
- In some cases, libraries that were never used were imported. This most commonly happened with importing `Set` on problems that benefit from sets, such as `p03_dedupe`.

### Scheme

- Translations from imperative languages were highly likely to include mutability and `set!`, particularly for loops. This lowered the idiomaticity score significantly.
- Translations from Haskell and Prolog both tended to be rather idiomatic.
- Most translations were longer and more complex than was needed.

### Python

- Generally idiomatic, regardless of source language. 
- Translations from non-imperative languages were more likely to use excessive recursion and functional structures.
- Many translations (especially from Haskell) had unnecessary, unused `import sys` statements.
- Import statements were often missing, especially `import re`.
