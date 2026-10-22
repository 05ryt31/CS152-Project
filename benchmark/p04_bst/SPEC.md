# p04_bst: BST insert, inorder, preorder, height

Read one line of distinct integers, insert them left to right into a binary search tree (smaller goes left), then
print three lines: the inorder traversal, the preorder traversal, and the height (number of nodes on the longest
root-to-leaf path; empty tree has height 0). Example: `5 3 8 1 4` -> `1 3 4 5 8` / `5 3 1 4 8` / `3`.
Edge cases: empty input (three lines: empty, empty, `0`), sorted input (degenerate tree), single value.
Paradigm notes: functional rebuilds the tree on insert; imperative mutates nodes. The LLM translating
Python -> Haskell often keeps a mutable-node design via IORef, which the rubric should catch.
