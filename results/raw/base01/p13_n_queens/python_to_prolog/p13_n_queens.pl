:- use_module(library(lists)).
:- use_module(library(readutil)).

safe([], _, _).
safe([H|T], Row, Col) :-
    Col \= H,
    Diff is Row - H,
    Col \= H + Diff,
    Col \= H - Diff,
    safe(T, Row, Col).

count(N, Row, Columns, Total) :-
    Row == N,
    !,
    Total = 1.
count(N, Row, Columns, Total) :-
    findall(Col, safe(Columns, Row, Col), SafeCols),
    length(SafeCols, Count),
    maplist(
        fun((Col, Acc) -> 
            Columns1 = [Col | Columns],
            count(N, Row + 1, Columns1, NewAcc),
            Acc + NewAcc
        ),
        SafeCols,
        [Total]
    ).

p13_n_queens :-
    read_line_to_string(current_input, Line),
    number_codes(Number, Line),
    count(Number, 0, [], Result),
    format('~d~n', [Result]),
    halt.
