:- use_module(library(lists)).
:- use_module(library(readutil)).

p14_bfs :-
    read_line_to_string(current_input, Line),
    split_string(Line, ' ', '', First),
    [N, M | _] = First,
    N_int is string_to_integer(N),
    M_int is string_to_integer(M),
    initialize_neighbours(N_int, M_int, Neighbours),

    read_lines(M_int, Neighbours, Edges),
    add_edges(Edges, Neighbours, FinalNeighbours),

    read_line_to_string(current_input, LastLine),
    split_string(LastLine, ' ', '', Last),
    [StartStr, TargetStr | _] = Last,
    Start is string_to_integer(StartStr),
    Target is string_to_integer(TargetStr),

    bfs(FinalNeighbours, Start, Target, Distance),
    format('~d~n', [Distance]),
    halt.

initialize_neighbours(N, _, [[] | _]) :-
    length(List, N),
    maplist(=([]), List).

read_lines(0, _, _) :- !.
read_lines(N, Neighbours, [Edge | Edges]) :-
    read_line_to_string(current_input, Line),
    split_string(Line, ' ', '', Edge),
    read_lines(N-1, Neighbours, Edges).

add_edges([], _, Neighbours) :- !.
add_edges([[U, V], Rest], Neighbours, NewNeighbours) :-
    append(Neighbours, [[U, V], [V, U]], Temp),
    add_edges(Rest, Temp, NewNeighbours).

bfs(Neighbours, Start, Target, Distance) :-
    findall(-1, between(1, Length, _), DistanceList),
    Length is length(Neighbours),
    nth0(Start, DistanceList, StartDist),
    StartDist = 0,
    bfs_helper(Neighbours, Start, Target, DistanceList, Visited),
    nth0(Target, DistanceList, Result),
    Result \= -1.

bfs_helper(_, _, _, [], _) :- !.
bfs_helper(Neighbours, Node, Target, DistanceList, Visited) :-
    findall(X, (member([Node, X], Neighbours), \+ member(X, Visited)), NextNodes),
    update_distances(DistanceList, NextNodes, NewDistanceList),
    append(Visited, NextNodes, NewVisited),
    bfs_helper(Neighbours, Target, Target, NewDistanceList, NewVisited).

update_distances(DistanceList, [], DistanceList).
update_distances(DistanceList, [X | Xs], NewDistanceList) :-
    nth0(X, DistanceList, CurrentDist),
    NewDist is CurrentDist + 1,
    nth0(X, DistanceList, NewDist),
    update_distances(DistanceList, Xs, NewDistanceList).
