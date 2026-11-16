:- use_module(library(lists)).
:- use_module(library(readutil)).

safe(Queens, Col) :-
    safe_loop(Queens, Col, 1).

safe_loop([], _, _).
safe_loop([Row | Rest], Col, Dist) :-
    \+ (Row = Col ; Row =:= Col + Dist ; Row =:= Col - Dist),
    Dist1 is Dist + 1,
    safe_loop(Rest, Col, Dist1).

count(0, [], 1).
count(N, Queens, Total) :-
    N > 0,
    count_row(0, N, Queens, Total).

count_row(Col, N, Queens, Total) :-
    Col =< N,
    (   safe(Queens, Col),
        NewQueens = [Col | Queens],
        NextCol is Col + 1,
        count(NextCol, NewQueens, Total1)
    ;
        NextCol is Col + 1,
        count_row(NextCol, N, Queens, Total)
    ),
    !,
    Total is Total1.

p13_n_queens :-
    read_line_to_string(current_input, Line),
    Number is string_to_number(Line),
    count(Number, [], Result),
    format('~d~n', [Result]),
    halt.
