:- use_module(library(lists)).
:- use_module(library(readutil)).

read_nums(S, L) :-
    atom_codes(S, Codes),
    split_string(Codes, " ", "", Words),
    maplist(atom_number, Words, L).

p14_bfs :-
    read_line_to_string(current_input, Line1),
    read_nums(Line1, [N, M]),
    findall(Edge, (between(1, M, _), read_line_to_string(current_input, Line2), read_nums(Line2, Edge)), Edges),
    read_line_to_string(current_input, Line3),
    read_nums(Line3, [S, T]),

    build_graph(Edges, N, Graph),
    bfs(Graph, S, T, Result),

    format('~d~n', [Result]),
    halt.

build_graph(Edges, N, Graph) :-
    init_graph(N, Graph0),
    foldl(add_edge, Edges, Graph0, Graph).

init_graph(N, Graph) :-
    length(Graph, N),
    maplist(init_node, Graph).

init_node([], _).
init_node([_ | Tail], Node) :-
    Node = [], init_node(Tail, Node).

add_edge([U, V], Graph, NewGraph) :-
    add_to_list(U, V, Graph, NewGraph1),
    add_to_list(V, U, NewGraph1, NewGraph).

add_to_list(_, _, [], []).
add_to_list(Node, Value, [Head | Tail], [NewHead | Tail]) :-
    Head = Node, append(Head, [Value], NewHead), !.
add_to_list(Node, Value, [Head | Tail], [Head | NewTail]) :-
    add_to_list(Node, Value, Tail, NewTail).

bfs(Graph, Start, End, Result) :-
    bfs_queue([(Start, 0)], IS.singleton(Start), Graph, End, Result).

bfs_queue(Queue, Seen, Graph, End, Result) :-
    Queue = [],
    Result = -1.
bfs_queue([(Node, D) | Tail], Seen, Graph, End, Result) :-
    Node = End,
    Result = D.
bfs_queue([(Node, D) | Tail], Seen, Graph, End, Result) :-
    \+ memberchk(Node, Seen),
    findall(Next, (member(Next, Graph), \+ memberchk(Next, Seen)), Neighbors),
    NewSeen = union(Seen, Neighbors),
    NewQueue = append(Tail, [(Next, D + 1) | Nexts]),
    bfs_queue(NewQueue, NewSeen, Graph, End, Result).
