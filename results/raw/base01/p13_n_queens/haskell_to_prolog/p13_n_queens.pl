:- use_module(library(lists)).
:- use_module(library(readutil)).

safe(Cols, Col) :-
    all(\(C, D) -> C \= Col, abs(C - Col) \= D), Cols, [_, D|_]).

count(N, Row, Cols, Count) :-
    Row == N,
    !,
    Count is 1.
count(N, Row, Cols, Count) :-
    Row < N,
    findall(NewCols, (between(0, N-1, Col),
                       safe(Cols, Col),
                       NewCols = [Col|Cols]), NewColsList),
    length(NewColsList, NewCount),
    count(N, Row + 1, Cols, OldCount),
    Count is OldCount + NewCount.

p13_n_queens :-
    read_line_to_string(current_input, NStr),
    atom_number(NStr, N),
    count(N, 0, [], Count),
    format('~d~n', [Count]),
    halt.
