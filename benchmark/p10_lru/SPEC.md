# p10_lru: LRU cache simulation

Read the capacity c (1-100) and an integer n, then n operations: `get K` prints the value or `-1` (a hit makes K
most recently used); `put K V` inserts or updates and evicts the least recently used key when over capacity;
neither prints for `put`. Example: `2` / `4` / `put 1 10` / `put 2 20` / `get 1` / `put 3 30` -> `10` (and key 2 is
evicted). Edge cases: capacity 1, update of an existing key refreshes recency, get of a missing key.
Paradigm notes: the hardest state problem for functional and logic targets; an ordered map plus a counter is the
idiomatic functional answer. Expect the largest correctness-vs-idiomaticity gap here.
