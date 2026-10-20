# p05_expr_tree: Postfix to fully parenthesised infix

Read one line of space-separated postfix tokens (non-negative integers and `+ - *`; no unary minus, so `-` is
always binary), build the expression tree, and print the fully parenthesised infix form. Example: `3 4 + 2 *` -> `((3 + 4) * 2)`. A single number prints
itself without parentheses. Edge cases: nested same-operator chains, single token.
Paradigm notes: algebraic data type plus one recursive printer; imperative versions use a stack of strings and
skip the tree, which still passes the tests (relevant to the readability/idiomaticity gap).
