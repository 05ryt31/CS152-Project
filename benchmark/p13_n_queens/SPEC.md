# p13_n_queens: Count N-queens solutions

Read n (1-8) and print the number of ways to place n queens on an n x n board with no two attacking.
Example: `6` -> `4`, `8` -> `92`. Edge cases: `1` -> `1`, `2` -> `0`, `3` -> `0`.
Paradigm notes: the canonical Prolog program (permutation + safety check). Imperative targets need explicit
backtracking; translations from Prolog into Python are the direction the proposal expects to be hardest.
