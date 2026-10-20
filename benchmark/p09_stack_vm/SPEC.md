# p09_stack_vm: Tiny stack machine

Read an integer n, then n instructions from `push X`, `pop`, `add`, `mul`, `dup`, `swap`, `print`. `print` outputs
the top of the stack without popping. Any instruction that needs more values than the stack holds prints `error`
and is ignored. Example: `5` / `push 2` / `push 3` / `add` / `dup` / `print` -> `5`. Edge cases: `pop` on empty,
`swap` with one element, `print` on empty prints `error`.
Paradigm notes: an interpreter loop with a mutable stack; the functional version threads the stack explicitly.
Related to CLO 6 (design interpreters).
