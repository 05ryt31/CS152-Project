# p06_calc: Infix calculator with parentheses

Read one line containing an arithmetic expression over non-negative integers with `+`, `-`, `*`, parentheses,
and optional spaces, and print its integer value. Standard precedence (`*` before `+`/`-`), left associativity.
No division. Example: `2 + 3 * (4 - 1)` -> `11`. Edge cases: deeply nested parentheses, a bare number, leading
and trailing spaces, results that are negative.
Paradigm notes: recursive-descent parser (CS 152 CLO 4). Prolog can use a DCG; the imperative habit of a mutable
token cursor is what to watch in Haskell/Scheme output.
