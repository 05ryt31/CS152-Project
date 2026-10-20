# p02_merge_sorted: Merge two sorted lists

Read two lines, each a space-separated non-decreasing list of integers (possibly empty), and print their merge as
one non-decreasing line. Output an empty line's worth of nothing if both are empty. Example: `1 3 5` and `2 3 6`
-> `1 2 3 3 5 6`. Edge cases: one empty list, duplicates across lists, negative numbers.
Paradigm notes: textbook structural recursion; Prolog's version is the classic two-clause predicate.
