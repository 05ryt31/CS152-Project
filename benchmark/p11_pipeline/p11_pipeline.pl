:- initialization(p11_pipeline, main).
p11_pipeline :- 
    read_line_to_string(user_input, Line), 
    split_string(Line, " ", " ", Parts), 
    maplist(number_string, Values, Parts), 
    read_line_to_string(user_input, KLine), 
    number_string(K, KLine), 
    stages(K, Values, Result), 
    output(Result),
    halt.

stages(0, Values, Values).
stages(K, Values, Result) :- 
    K > 0, 
    read_line_to_string(user_input, Line), 
    split_string(Line, " ", " ", Parts), 
    apply_stage(Parts, Values, New), 
    K1 is K - 1, 
    stages(K1, New, Result).

apply_stage(["map", "add", X], Values, Result) :- 
    number_string(N, X), 
    maplist(add(N), Values, Result).
apply_stage(["map", "mul", X], Values, Result) :- 
    number_string(N, X), 
    maplist(multiply(N), Values, Result).
apply_stage(["filter", "even"], Values, Result) :- include(even, Values, Result).
apply_stage(["filter", "odd"], Values, Result) :- include(odd, Values, Result).
apply_stage(["filter", "gt", X], Values, Result) :- 
    number_string(N, X), 
    include(greater(N), Values, Result).
apply_stage(["reduce", "sum"], Values, [Result]) :- sum_list(Values, Result).
apply_stage(["reduce", "max"], [], none).
apply_stage(["reduce", "max"], Values, [Result]) :- max_list(Values, Result).

add(N, X, Y) :- Y is X + N.
multiply(N, X, Y) :- Y is X * N.
even(X) :- 0 is X mod 2.
odd(X) :- 1 is X mod 2.
greater(N, X) :- X > N.

output(none) :- writeln(none).
output([]).
output(Values) :- 
    Values \= [], 
    atomic_list_concat(Values, ' ', Text), 
    writeln(Text).
