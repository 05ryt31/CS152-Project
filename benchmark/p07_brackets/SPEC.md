# p07_brackets: Balanced brackets check

Read an integer n, then n lines of strings over `()[]{}` (possibly empty), and print `yes` or `no` for each,
one per line, depending on whether the brackets are balanced and properly nested. Example: `2` / `([]{})` / `([)]`
-> `yes` / `no`. Edge cases: empty string is `yes`, unmatched opener at the end, lone closer.
Paradigm notes: stack or recursion; small enough that all six should score well. Serves as a sanity anchor.
