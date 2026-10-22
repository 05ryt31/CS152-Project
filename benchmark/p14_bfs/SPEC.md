# p14_bfs: Shortest path length in an unweighted graph

Read integers n and m, then m lines `u v` (undirected edges between nodes 1..n), then a line `s t`. Print the
number of edges on a shortest path from s to t, or `-1` if unreachable. Example: `4 3` / `1 2` / `2 3` / `3 4` /
`1 4` -> `3`. Edge cases: s = t prints `0`, disconnected graph, duplicate edges.
Paradigm notes: BFS wants a queue and a visited set, which is imperative-shaped; the functional version is a
level-by-level fold, the Prolog version is where "procedural Prolog" with `nb_setval` tends to appear.
