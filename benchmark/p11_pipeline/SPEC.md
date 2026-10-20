# p11_pipeline: map / filter / reduce command pipeline

Read one line of space-separated integers, then an integer k, then k pipeline stages from `map add X`,
`map mul X`, `filter even`, `filter odd`, `filter gt X`, `reduce sum`, `reduce max`. Apply them in order and
print the final line: a space-separated list, or a single number after a `reduce` (which must be last). `reduce max`
on an empty list prints `none`; `reduce sum` on an empty list prints `0`. Example: `1 2 3 4` / `2` / `map mul 3` /
`filter even` -> `6 12`. Edge cases: no stages, filter that empties the list, reduce on empty.
Paradigm notes: the point of the category; Prolog has no first-class functions, so `maplist`/`foldl` with
`call/N` or hand-written recursion is what the rubric looks for.
