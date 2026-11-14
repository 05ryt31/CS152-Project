:- use_module(library(aggregate)).

p13_n_queens :- 
    read_line_to_string(user_input, Line), 
    number_string(N, Line), 
    aggregate_all(count, n_queens(N, _), Result), 
    writeln(Result),
    halt.

n_queens(N, Columns) :-
    n_queens(N, 0, [], Columns).

n_queens(N, N, Columns, Columns).
n_queens(N, Row, Columns, Result) :- 
    Row < N, 
    Last is N - 1, 
    between(0, Last, Col), 
    safe(Columns, 1, Col), 
    Row1 is Row + 1, 
    n_queens(N, Row1, [Col|Columns], Result).

safe([], _, _).
safe([Previous|Rest], Dist, Col) :- 
    Previous =\= Col, 
    abs(Previous - Col) =\= Dist, 
    Dist1 is Dist + 1, 
    safe(Rest, Dist1, Col).
