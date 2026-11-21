:- use_module(library(lists)).
:- use_module(library(readutil)).

read_graph(M, Graph) :-
    read_lines(M, Lines),
    maplist(parse_edge, Lines, Edges),
    build_graph(Edges, Graph).

parse_edge(Line, Edge) :-
    split_string(Line, " ", _, Parts),
    maplist(string_to_number, Parts, [U, V]),
    Edge = [U, V].

build_graph(Edges, Graph) :-
    findall([U, V], member([U, _], Edges), UList),
    findall([V, U], member([_, V], Edges), VList),
    append(UList, VList, All),
    sort(All, Nodes),
    maplist(find_neighbors(Nodes, Edges), Nodes, Neighbors),
    pairs_keys_values(Graph, Nodes, Neighbors).

find_neighbors(_, [], _).
find_neighbors(Nodes, [Edge | Rest], Acc) :-
    member(Edge, Nodes),
    find_neighbors(Nodes, Rest, Acc),
    !.
find_neighbors(Nodes, [_ | Rest], Acc) :-
    find_neighbors(Nodes, Rest, Acc).

get_neighbors(Node, Graph, Neighbors) :-
    member([Node, Neighbors], Graph).

expand_layer(Layer, Graph, Visited, NextLayer, NewVisited) :-
    expand_layer(Layer, Graph, Visited, [], NextLayer, NewVisited).

expand_layer([], _, _, Acc, Acc, Acc).
expand_layer([Node | Rest], Graph, Visited, Acc, NextLayer, NewVisited) :-
    get_neighbors(Node, Graph, Neighbors),
    filter(not_member(Visited), Neighbors, NewNeighbors),
    append(Acc, NewNeighbors, NewAcc),
    expand_layer(Rest, Graph, Visited, NewAcc, NextLayer, NewVisited).

not_member(X, []) :- !, fail.
not_member(X, [H | T]) :-
    X \= H,
    not_member(X, T).

bfs(Start, Target, Graph, Distance) :-
    bfs_loop([[Start]], [[Start]], 0, Target, Graph, Distance).

bfs_loop([], _, _, _, _, -1).
bfs_loop([[Target | _] | _], _, _, _, _, 0).
bfs_loop([Layer | Rest], Visited, Dist, Target, Graph, Distance) :-
    expand_layer(Layer, Graph, Visited, NextLayer, NewVisited),
    bfs_loop(Rest, NewVisited, Dist + 1, Target, Graph, Distance).

p14_bfs :-
    read_line_to_string(current_input, Line),
    split_string(Line, " ", _, Parts),
    maplist(string_to_number, Parts, [N, M]),
    read_graph(M, Graph),
    read_line_to_string(current_input, Line),
    split_string(Line, " ", _, Parts),
    maplist(string_to_number, Parts, [S, T]),
    bfs(S, T, Graph, Distance),
    format("~d~n", [Distance]),
    halt.
