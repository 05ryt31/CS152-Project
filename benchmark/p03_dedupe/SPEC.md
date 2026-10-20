# p03_dedupe: Deduplicate preserving first occurrence

Read one line of space-separated integers and print them with duplicates removed, keeping the first occurrence
order. Example: `3 1 3 2 1` -> `3 1 2`. Edge cases: empty line, all duplicates, already unique.
Paradigm notes: needs "seen" state; imperative uses a set, functional threads an accumulator, Prolog needs an
explicit accumulator or `memberchk`, which is where cut-driven versions appear.
