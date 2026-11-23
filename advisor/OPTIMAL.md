# Optimal picks for paradigm and language recommendations

## Summary

| Id | Paradigm | Language | Alternate Paradigms | Alternate Languages | Least Optimal |
|---|---|---|---|---|---|
| p01_rle | functional | Haskell/Scheme | imperative-oo | Python, JavaScript | logic |
| p02_merge_sorted | functional | Haskell/Scheme | - | Python, JavaScript | - |
| p03_dedupe | imperative-oo | Java/Python | - | JavaScript | logic |
| p04_bst | functional | Haskell/Scheme | - | Python, JavaScript | - |
| p05_expr_tree | functional | Haskell/Scheme | - | Python, JavaScript | - |
| p06_calc | imperative-oo | Java/Python | functional | Haskell, Scheme, JavaScript | - |
| p07_brackets | imperative-oo | Java/Python | - | JavaScript | - |
| p08_bank | imperative-oo | Java/Python/JavaScript | - | - | functional, logic |
| p09_stack_vm | imperative-oo | Java/Python | - | JavaScript | - |
| p10_lru | imperative-oo | Java/Python/JavaScript | - | - | logic, functional |
| p11_pipeline | functional | Haskell/Scheme | - | Python, JavaScript | logic |
| p12_group_by | imperative-oo | Python/JavaScript | functional | Java, Haskell, Scheme | - |
| p13_n_queens | logic | Prolog | - | - | imperative-oo |
| p14_bfs | imperative-oo | Java/Python | - | - | logic |
| p15_permutations | logic | Prolog | functional | Haskell/Scheme | imperative-oo |

## Reasoning

Due to the high success rate of Python in the baseline run, both in terms of idiomaticity and pass rate, it is an acceptable selection for most problems. The most important factor is whether the better *paradigm* is selected when Python is chosen: in some cases, functional Python may be better than imperative Python.

The optimal language is more relaxed, since the languages within each paradigm are relatively similar to each other. However, since JavaScript is more functional than the other imperative/OO languages, and Java is more strictly OO, these two languages may not be as optimal for problems that do not as strongly favor their paradigm.

### p01_rle

Run-length encoding favors the functional paradigm, since it can be achieved relatively simply using higher-order functions. However, imperative/OO is a valid alternative, including imperative languages with functional features, such as Python and JavaScript. The logic paradigm is the least optimal, due to the general lack of higher-order functions.

### p02_merge_sorted

Merging two sorted lists is most easily done with functional languages, such as Haskell and Scheme, since it can be done in a simple recursive loop. However, this simplicity means that any paradigm or language works as well.

### p03_dedupe

Deduplication is easily done with a set, which favors imperative/OO languages due to the need for state management. Since logic languages, such as Prolog, may lack this data structure, they are less preferable.

### p04_bst

Functional languages handle BST operations well due to their preferences for recursion and immutability.

### p05_expr_tree

Expression tree construction is favored by functional languages due to the extensive use of recursion.

### p06_calc

Both imperative/OO and functional languages handle infix calculation well through the use of recursion. Prolog can also handle infix calculation relatively simply using built-in methods, but it does not solve the problem as explicitly.

### p07_brackets

Imperative languages handle balanced brackets best by using a stack, but the relative simplicity of the problem means that it works well in all paradigms and languages.

### p08_bank

Since the bank problem includes a heavy use of state, imperative/OO languages are best-suited to it. Functional and logic languages will struggle with state management.

### p09_stack_vm

As with `p08_bank`, the stack machine problem usually includes the use of state, which makes imperative/OO languages more favorable. However, functional and logic approaches may also be acceptable, as the use of state is less explicit than in `p08_bank`.

### p10_lru

As with `p08_bank`, the LRU cache problem involves very heavy state usage, which strongly favors imperative/OO languages over logic or functional ones.

### p11_pipeline

The use of `map`, `filter`, and `reduce` higher-order functions in the pipeline problem generally favors functional languages. Since logic languages generally lack higher-order functions, they are more likely to struggle with an elegant solution.

### p12_group_by

The group by keys problem often uses state, which favors imperative/OO languages. However, functional languages may also have an elegant solution, with the use of map data structures.

### p13_n_queens

Since the N-queens problem relies on backtracking, it strongly favors the logic paradigm. In contrast, imperative/OO languages often need excessive recursion or looping to solve the problem.

### p14_bfs

BFS is easily solved with a queue, while the recursive solution is less elegant, which favors imperative/OO languages. Without easy access to a queue data structure, logic languages often struggle more with an optimal solution.

### p15_permutations

The potential for backtracking in computing paradigms favors Prolog and the logic paradigm. However, functional languages may also be able to obtain an elegant solution through recursion. In contrast, imperative/OO languages may struggle with excessive recursion or looping.
