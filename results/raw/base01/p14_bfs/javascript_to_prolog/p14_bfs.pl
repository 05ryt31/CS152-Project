:- use_module(library(lists)).
:- use_module(library(readutil)).

p14_bfs :-
    read_lines(InputLines),
    parse_input(InputLines, N, M, Graph, Start, Target),
    bfs(Graph, Start, Target, Distance),
    format('~d~n', [Distance]),
    halt.

read_lines(InputLines) :-
    read_string(current_input, _, Input),
    split_string(Input, '\n', '', Lines),
    maplist(trim, Lines, InputLines).

parse_input([_ | Rest], N, M, Graph, Start, Target) :-
    split_string(Rest, ' ', '', [NStr, MStr]),
    number_codes(N, NStr),
    number_codes(M, MStr),
    initialize_graph(N, Graph),
    parse_edges(Rest, M, Graph, Edges),
    parse_nodes(Edges, Start, Target).

initialize_graph(N, Graph) :-
    length(Graph, N+1),
    maplist(init_list, Graph).

init_list([]).

parse_edges(_, 0, _, _).

parse_edges(Lines, M, Graph, Edges) :-
    split_string(Lines, ' ', '', [UStr, VStr]),
    number_codes(U, UStr),
    number_codes(V, VStr),
    append(Edges, [[U, V]], NewEdges),
    M1 is M - 1,
    parse_edges(Lines, M1, Graph, NewEdges).

parse_nodes(Edges, Start, Target) :-
    member([Start, _], Edges),
    member([_, Target], Edges).

bfs(Graph, Start, Target, Distance) :-
    initialize_distance(Distance, Start),
    bfs_loop(Graph, [Start], [], Distance, Target).

initialize_distance(Distance, Start) :-
    length(Distance, Length),
    fill_list(Length, -1, Distance),
    nth0(Start, Distance, 0).

fill_list(0, _, _).
fill_list(N, Value, List) :-
    N > 0,
    NewN is N - 1,
    append(List, [Value], NewList),
    fill_list(NewN, Value, NewList).

bfs_loop(_, [], _, Distance, _) :-
    !.

bfs_loop(Graph, Queue, Visited, Distance, Target) :-
    Queue = [Node | _],
    Node == Target,
    !,
    nth0(Target, Distance, Result),
    Result >= 0,
    format('~d~n', [Result]),
    halt.

bfs_loop(Graph, [Node | Tail], Visited, Distance, Target) :-
    findall(Next, (member([Node, Next], Graph), \+ member(Next, Visited)), Neighbors),
    extend_queue(Tail, Neighbors, NewQueue),
    update_distance(Graph, Distance, Neighbors, NewDistance),
    bfs_loop(Graph, NewQueue, [Node | Visited], NewDistance, Target).

extend_queue(Queue, [], Queue).

extend_queue(Queue, [Neighbor | Tail], [Neighbor | NewQueue]) :-
    extend_queue(Queue, Tail, NewQueue).

update_distance(Graph, Distance, [], Distance).

update_distance(Graph, Distance, [Neighbor | Tail], NewDistance) :-
    nth0(Neighbor, Distance, OldDist),
    (   OldDist < 0 ->
        NewDist is OldDist + 1,
        set_nth0(Neighbor, NewDist, Distance, NewDistance)
    ;   true ),
    update_distance(Graph, Distance, Tail, NewDistance).

set_nth0(Index, Value, List, NewList) :-
    nth0(Index, List, _, Tail),
    append(List, [Value | Tail], NewList).
