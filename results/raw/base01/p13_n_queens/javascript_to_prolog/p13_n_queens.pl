:- use_module(library(lists)).
:- use_module(library(readutil)).

safe([], _, _).
safe([H|T], Row, Col) :-
    Col \= H,
    Diff is abs(Col - H),
    Diff \= Row,
    safe(T, Row, Col).

count(_, [], _).
count(N, Columns, Count) :-
    length(Columns, N),
    !,
    Count is 1.
count(N, [H|T], Count) :-
    findall(Col, safe(T, 0, Col), SafeCols),
    maplist((lambda([Col], count(N, [Col|T], NewCount), Count is Count + NewCount)), SafeCols).

p13_n_queens :-
    read_line_to_string(current_input, Input),
    N is string_to_integer(Input),
    count(N, [], Result),
    format('~d~n', [Result]),
    halt.
