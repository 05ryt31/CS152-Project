:- initialization(p14_bfs, main).

p14_bfs :- 
    read_line_to_string(user_input, First), 
    split_string(First, " ", " ", [NS, MS]), 
    number_string(N, NS), 
    number_string(M, MS), 
    edges(M, [], Graph), 
    read_line_to_string(user_input, Last), 
    split_string(Last, " ", " ", [SS, TS]), 
    number_string(S, SS), 
    number_string(T, TS), 
    bfs([(S,0)], [S], Graph, T, Result), 
    writeln(Result),
    halt.

edges(0, Graph, Graph).
edges(N, Graph, Result) :- 
    read_line_to_string(user_input, Line), 
    split_string(Line, " ", " ", [US, VS]), 
    number_string(U, US), 
    number_string(V, VS), 
    add_edge(U, V, Graph, New), 
    N1 is N - 1, 
    edges(N1, New, Result).

add_edge(U, V, Graph, New) :- 
    update_adj(U, V, Graph, A), 
    update_adj(V, U, A, New).

update_adj(U, V, [], [U-[V]]).
update_adj(U, V, [U-Neighbor|Rest], [U-[V|Neighbor]|Rest]).
update_adj(U, V, [Other|Rest], [Other|NewRest]) :- 
    U \= Other, 
    update_adj(U, V, Rest, NewRest).

adj(Node, [Node-Neighbor|_], Neighbor).
adj(Node, [_|Rest], Neighbor) :- adj(Node, Rest, Neighbor).
adj(_, [], []).

bfs([], _, _, _, -1) :- !.
bfs([(Node,Distance)|_], _, _, Node, Distance) :- !.
bfs([(Node,Distance)|Queue], Seen, Graph, Target, Result) :- 
    adj(Node, Graph, Neighbors), 
    unseen(Neighbors, Seen, New, Added), 
    Distance1 is Distance + 1, 
    pairs(Added, Distance1, Entries), 
    append(Queue, Entries, NewQueue), 
    bfs(NewQueue, New, Graph, Target, Result).

unseen([], Seen, Seen, []).
unseen([X|Xs], Seen, New, Added) :- 
    memberchk(X, Seen), 
    unseen(Xs, Seen, New, Added).
unseen([X|Xs], Seen, New, [X|Added]) :- 
    \+ memberchk(X, Seen), 
    unseen(Xs, [X|Seen], New, Added).

pairs([], _, []).
pairs([X|Xs], D, [(X,D)|Rest]) :- pairs(Xs, D, Rest).
