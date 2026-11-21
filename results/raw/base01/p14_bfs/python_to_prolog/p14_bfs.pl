:- use_module(library(lists)).
:- use_module(library(readutil)).

p14_bfs :-
    read_line_to_string(current_input, Line),
    atom_codes(Line, Codes),
    split_string(Codes, ' ', '', [N, M]),
    maplist(string_to_integer, [N, M], [N, M]),
    findall(_, (between(1, N, Node), assertz(neighbour(Node, []))), _),
    repeat,
        read_line_to_string(current_input, Line),
        atom_codes(Line, Codes),
        split_string(Codes, ' ', '', [U, V]),
        maplist(string_to_integer, [U, V], [U, V]),
        neighbour(U, Neighbours1),
        append(Neighbours1, [V], Neighbours2),
        retractall(neighbour(U, _)),
        assertz(neighbour(U, Neighbours2)),
        neighbour(V, Neighbours3),
        append(Neighbours3, [U], Neighbours4),
        retractall(neighbour(V, _)),
        assertz(neighbour(V, Neighbours4)),
        !,
    fail,
    read_line_to_string(current_input, Line),
    atom_codes(Line, Codes),
    split_string(Codes, ' ', '', [S, T]),
    maplist(string_to_integer, [S, T], [S, T]),
    bfs(S, T, Distance),
    (   member(T, Distance)
    ->  format('~d~n', [Distance[T]])
    ;   format('-1~n')
    ),
    halt.

bfs(S, T, Distance) :-
    bfs(S, T, [], [S], Distance).

bfs(S, S, _, _, _) :- !.
bfs(S, T, Visited, Queue, Distance) :-
    dequeue(Queue, NewQueue, Head),
    (   member(Head, Visited)
    ->  bfs(S, T, Visited, NewQueue, Distance)
    ;   findall(NewNode, (neighbour(Head, Nodes), member(NewNode, Nodes), \+ member(NewNode, Visited)), NewNodes),
        append(NewNodes, NewQueue, NewNewQueue),
        update_distance(Head, NewNodes, Distance, NewDistance),
        bfs(S, T, [Head | Visited], NewNewQueue, NewDistance)
    ).

dequeue([H | T], T, H).

update_distance(Node, NewNodes, Distance, NewDistance) :-
    findall(Dist, (member(NewNode, NewNodes), get_distance(Distance, NewNode, Dist)), Dists),
    max_list(Dists, MaxDist),
    put_distance(NewDistance, Node, MaxDist + 1).

get_distance(Distance, Node, Dist) :-
    member(Node-Dist, Distance).
put_distance(Distance, Node, Dist) :-
    retractall(get_distance(Distance, Node, _)),
    assertz(get_distance(Distance, Node, Dist)).

string_to_integer(String, Integer) :-
    number_string(Integer, String).
