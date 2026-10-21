# p12_group_by: Group by key, sum and count

Read an integer n, then n lines `key value` where key is a word and value an integer. Print one line per distinct
key in ascending key order: `key sum count`. Example: `3` / `b 2` / `a 5` / `b 4` -> `a 5 1` / `b 6 2`.
Edge cases: n = 0 prints nothing, negative values, a single key.
Paradigm notes: a `groupBy`/`foldl` into a map in functional languages, a dictionary loop imperatively,
`findall`/`msort`/`aggregate_all` in Prolog. A good RQ4 case: the advisor may pick any paradigm.
