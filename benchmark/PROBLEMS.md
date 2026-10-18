# Benchmark problems (Issue #4)

Status: **draft for both authors to edit.** 15 problems, 2-3 per CS 152 concept category (trimmed from a
20-problem draft on Oct 17; the five dropped titles are listed under Open points). Each must be
20-80 lines in every one of the six languages, deterministic, and testable through stdin/stdout only.

Conventions (from `harness/EXECUTION.md`): one folder per problem under `benchmark/<id>/`, containing
`SPEC.md` (the paragraph below), `tests.json` (`[{name, input, output}]`, 5-10 cases including edge cases),
and the reference programs named `<id>.py`, `<id>.js`, `<Id>.java` (package `benchmark.<id>`), `<id>.scm`,
`<id>.hs`, `<id>.pl` (entry predicate `<id>/0`). Ids are lowercase identifiers so they work as Java packages.

Numbers are integers only (no floats, so formatting is identical across languages). Division, where used, is
integer division truncating toward zero on non-negative operands only. Strings are ASCII. Output lines end
with `\n`; empty output means print nothing.

**Paradigm notes** record, before we run anything, which paradigm each problem favours or fights. They feed
RQ3 (direction and difficulty) and RQ4 (does the advisor's recommendation match the empirically best paradigm).

## Summary

| Id | Category | Title | Favours | Fights |
|---|---|---|---|---|
| p01_rle | recursion / list | Run-length encoding | functional | - |
| p02_merge_sorted | recursion / list | Merge two sorted lists | functional, logic | - |
| p03_dedupe | recursion / list | Deduplicate preserving first occurrence | imperative | logic (needs an accumulator) |
| p04_bst | tree traversal | BST insert, inorder, preorder, height | functional | imperative (mutation vs rebuild) |
| p05_expr_tree | tree traversal | Postfix to fully parenthesised infix | functional | - |
| p06_calc | expression / parsing | Infix calculator with parentheses | functional, oo | logic (precedence by DCG is fine, but mutation of a cursor is the imperative habit) |
| p07_brackets | expression / parsing | Balanced brackets check | functional | - |
| p08_bank | state management | Bank account command log | oo, imperative | functional, logic (threaded state) |
| p09_stack_vm | state management | Tiny stack machine | imperative | functional (state passing) |
| p10_lru | state management | LRU cache simulation | oo, imperative | logic, functional |
| p11_pipeline | higher-order | map / filter / reduce command pipeline | functional | logic (no first-class functions) |
| p12_group_by | higher-order | Group by key, sum and count | functional, imperative | - |
| p13_n_queens | search / constraint | Count N-queens solutions | logic | imperative (explicit backtracking) |
| p14_bfs | search / constraint | Shortest path length in an unweighted graph | imperative | logic (BFS needs a queue) |
| p15_permutations | search / constraint | All permutations in sorted order | logic, functional | imperative |

Coverage by favoured paradigm: functional 9, imperative 5, logic 4, oo 3 (a problem can favour more than one).

## Recursion and list processing

### p01_rle: Run-length encoding
Read one line and print its run-length encoding: each maximal run of the same character becomes the character
followed by the run length. Input: one line of 1-200 printable ASCII characters without spaces. Output: one line.
Example: `aaabccdddd` -> `a3b1c2d4`. Edge cases: single character, no repeats, all the same.
Paradigm notes: one fold over the string; the imperative version is a loop with two variables.

### p02_merge_sorted: Merge two sorted lists
Read two lines, each a space-separated non-decreasing list of integers (possibly empty), and print their merge as
one non-decreasing line. Output an empty line's worth of nothing if both are empty. Example: `1 3 5` and `2 3 6`
-> `1 2 3 3 5 6`. Edge cases: one empty list, duplicates across lists, negative numbers.
Paradigm notes: textbook structural recursion; Prolog's version is the classic two-clause predicate.

### p03_dedupe: Deduplicate preserving first occurrence
Read one line of space-separated integers and print them with duplicates removed, keeping the first occurrence
order. Example: `3 1 3 2 1` -> `3 1 2`. Edge cases: empty line, all duplicates, already unique.
Paradigm notes: needs "seen" state; imperative uses a set, functional threads an accumulator, Prolog needs an
explicit accumulator or `memberchk`, which is where cut-driven versions appear.

## Tree traversal

### p04_bst: BST insert, inorder, preorder, height
Read one line of distinct integers, insert them left to right into a binary search tree (smaller goes left), then
print three lines: the inorder traversal, the preorder traversal, and the height (number of nodes on the longest
root-to-leaf path; empty tree has height 0). Example: `5 3 8 1 4` -> `1 3 4 5 8` / `5 3 1 4 8` / `3`.
Edge cases: empty input (three lines: empty, empty, `0`), sorted input (degenerate tree), single value.
Paradigm notes: functional rebuilds the tree on insert; imperative mutates nodes. The LLM translating
Python -> Haskell often keeps a mutable-node design via IORef, which the rubric should catch.

### p05_expr_tree: Postfix to fully parenthesised infix
Read one line of space-separated postfix tokens (non-negative integers and `+ - *`), build the expression tree,
and print the fully parenthesised infix form. Example: `3 4 + 2 *` -> `((3 + 4) * 2)`. A single number prints
itself without parentheses. Edge cases: nested same-operator chains, single token.
Paradigm notes: algebraic data type plus one recursive printer; imperative versions use a stack of strings and
skip the tree, which still passes the tests (relevant to the readability/idiomaticity gap).

## Expression evaluation and parsing

### p06_calc: Infix calculator with parentheses
Read one line containing an arithmetic expression over non-negative integers with `+`, `-`, `*`, parentheses,
and optional spaces, and print its integer value. Standard precedence (`*` before `+`/`-`), left associativity.
No division. Example: `2 + 3 * (4 - 1)` -> `11`. Edge cases: deeply nested parentheses, a bare number, leading
and trailing spaces, results that are negative.
Paradigm notes: recursive-descent parser (CS 152 CLO 4). Prolog can use a DCG; the imperative habit of a mutable
token cursor is what to watch in Haskell/Scheme output.

### p07_brackets: Balanced brackets check
Read an integer n, then n lines of strings over `()[]{}` (possibly empty), and print `yes` or `no` for each,
one per line, depending on whether the brackets are balanced and properly nested. Example: `2` / `([]{})` / `([)]`
-> `yes` / `no`. Edge cases: empty string is `yes`, unmatched opener at the end, lone closer.
Paradigm notes: stack or recursion; small enough that all six should score well. Serves as a sanity anchor.

## State management

### p08_bank: Bank account command log
Read an integer n, then n commands: `deposit X`, `withdraw X`, `balance`. Start from 0. `withdraw` that would go
below 0 prints `error` and leaves the balance unchanged; `balance` prints the current balance; `deposit` and
successful `withdraw` print nothing. Example: `4` / `deposit 50` / `withdraw 70` / `withdraw 20` / `balance` ->
`error` / `30`. Edge cases: withdraw exactly the balance, balance when 0, many errors in a row.
Paradigm notes: the OO shape (an account object) is natural; Haskell wants a fold or the State monad; Prolog must
thread the balance through a recursive predicate, where `assert`/`retract` is the non-idiomatic escape hatch.

### p09_stack_vm: Tiny stack machine
Read an integer n, then n instructions from `push X`, `pop`, `add`, `mul`, `dup`, `swap`, `print`. `print` outputs
the top of the stack without popping. Any instruction that needs more values than the stack holds prints `error`
and is ignored. Example: `5` / `push 2` / `push 3` / `add` / `dup` / `print` -> `5`. Edge cases: `pop` on empty,
`swap` with one element, `print` on empty prints `error`.
Paradigm notes: an interpreter loop with a mutable stack; the functional version threads the stack explicitly.
Related to CLO 6 (design interpreters).

### p10_lru: LRU cache simulation
Read the capacity c (1-100) and an integer n, then n operations: `get K` prints the value or `-1` (a hit makes K
most recently used); `put K V` inserts or updates and evicts the least recently used key when over capacity;
neither prints for `put`. Example: `2` / `4` / `put 1 10` / `put 2 20` / `get 1` / `put 3 30` -> `10` (and key 2 is
evicted). Edge cases: capacity 1, update of an existing key refreshes recency, get of a missing key.
Paradigm notes: the hardest state problem for functional and logic targets; an ordered map plus a counter is the
idiomatic functional answer. Expect the largest correctness-vs-idiomaticity gap here.

## Higher-order functions

### p11_pipeline: map / filter / reduce command pipeline
Read one line of space-separated integers, then an integer k, then k pipeline stages from `map add X`,
`map mul X`, `filter even`, `filter odd`, `filter gt X`, `reduce sum`, `reduce max`. Apply them in order and
print the final line: a space-separated list, or a single number after a `reduce` (which must be last). `reduce max`
on an empty list prints `none`; `reduce sum` on an empty list prints `0`. Example: `1 2 3 4` / `2` / `map mul 3` /
`filter even` -> `6 12`. Edge cases: no stages, filter that empties the list, reduce on empty.
Paradigm notes: the point of the category; Prolog has no first-class functions, so `maplist`/`foldl` with
`call/N` or hand-written recursion is what the rubric looks for.

### p12_group_by: Group by key, sum and count
Read an integer n, then n lines `key value` where key is a word and value an integer. Print one line per distinct
key in ascending key order: `key sum count`. Example: `3` / `b 2` / `a 5` / `b 4` -> `a 5 1` / `b 6 2`.
Edge cases: n = 0 prints nothing, negative values, a single key.
Paradigm notes: a `groupBy`/`foldl` into a map in functional languages, a dictionary loop imperatively,
`findall`/`msort`/`aggregate_all` in Prolog. A good RQ4 case: the advisor may pick any paradigm.

## Search and constraint problems

### p13_n_queens: Count N-queens solutions
Read n (1-8) and print the number of ways to place n queens on an n x n board with no two attacking.
Example: `6` -> `4`, `8` -> `92`. Edge cases: `1` -> `1`, `2` -> `0`, `3` -> `0`.
Paradigm notes: the canonical Prolog program (permutation + safety check). Imperative targets need explicit
backtracking; translations from Prolog into Python are the direction the proposal expects to be hardest.

### p14_bfs: Shortest path length in an unweighted graph
Read integers n and m, then m lines `u v` (undirected edges between nodes 1..n), then a line `s t`. Print the
number of edges on a shortest path from s to t, or `-1` if unreachable. Example: `4 3` / `1 2` / `2 3` / `3 4` /
`1 4` -> `3`. Edge cases: s = t prints `0`, disconnected graph, duplicate edges.
Paradigm notes: BFS wants a queue and a visited set, which is imperative-shaped; the functional version is a
level-by-level fold, the Prolog version is where "procedural Prolog" with `nb_setval` tends to appear.

### p15_permutations: All permutations in sorted order
Read one line of distinct lowercase letters (1-6) and print every permutation, one per line, in lexicographic
order. Example: `cab` -> `abc` / `acb` / `bac` / `bca` / `cab` / `cba`. Edge cases: one letter, already sorted,
reverse sorted.
Paradigm notes: `permutation/2` plus sorting in Prolog, `permutations` in Haskell/Scheme via recursion;
imperative versions tend to implement Heap's algorithm or next-permutation, which is longer and harder to read.

## Open points for sign-off

- [ ] OO is favoured by only three problems. Accept that OO shows up through the state-management problems, or
      swap one problem for an "inventory" style task (objects with fields, commands that mutate them)?
- [ ] p06_calc: allow unary minus? Current draft says no (keeps every language's parser at 40-60 lines).
- [ ] Test case count: 5-10 per problem. Who writes which tests is decided with the Python references (#6).
- [ ] Which problems get hand-written sources in all six languages (#7)? Suggested minimum: p02, p04, p06, p08,
      p11, p13 (one per category), the rest from verified LLM translations.
- Dropped on Oct 17 to reach 15 (can be revived if time allows): Pascal's triangle rows, depth and leaf count from
  an edge list, reverse Polish evaluation, compose string transforms, first subset with a given sum.
