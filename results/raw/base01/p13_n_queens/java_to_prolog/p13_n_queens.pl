:- use_module(library(lists)).
:- use_module(library(readutil)).

safe(_, _, []).
safe(Row, Col, [C|Cs]) :-
    Col \= C,
    Row - C \= abs(Row - C),
    safe(Row, Col, Cs).

count(N, N, _Columns) :- !, 1.
count(N, Row, Columns) :-
    findall(Col, (between(0, N-1, Col), safe(Row, Col, Columns)), SafeCols),
    length(SafeCols, Total),
    sum_list(Total, Result),
    count(N, Row + 1, Columns).

p13_n_queens :-
    read_line_to_string(current_input, Input),
    number_codes(Number, Input),
    count(Number, 0, []),
    format('~d~n', [Result]),
    halt.
