# p01_rle: Run-length encoding

Read one line and print its run-length encoding: each maximal run of the same character becomes the character
followed by the run length. Input: one line of 1-200 printable ASCII characters without spaces. Output: one line.
Example: `aaabccdddd` -> `a3b1c2d4`. Edge cases: single character, no repeats, all the same.
Paradigm notes: one fold over the string; the imperative version is a loop with two variables.
