# p15_permutations: All permutations in sorted order

Read one line of distinct lowercase letters (1-6) and print every permutation, one per line, in lexicographic
order. Example: `cab` -> `abc` / `acb` / `bac` / `bca` / `cab` / `cba`. Edge cases: one letter, already sorted,
reverse sorted.
Paradigm notes: `permutation/2` plus sorting in Prolog, `permutations` in Haskell/Scheme via recursion;
imperative versions tend to implement Heap's algorithm or next-permutation, which is longer and harder to read.
