:- use_module(library(readutil)).
:- use_module(library(lists)).

p11_pipeline :-
    read_lines(InputLines),
    process_lines(InputLines, Result),
    print_result(Result),
    halt.

read_lines([]) :-
    at_end_of_stream(current_input), !.
read_lines([Line | Lines]) :-
    read_line_to_string(current_input, Line),
    read_lines(Lines).

process_lines([], []).
process_lines([FirstLine | Rest], Result) :-
    FirstValues =.. [_, Values],
    maplist(number_string, Values, NumValues),
    K =.. [_, _K],
    read_line_to_string(current_input, KLine),
    number_string(_K, KNum),
    process_commands(Rest, NumValues, KNum, Result).

process_commands([], _, _, []).
process_commands(['map', Op, Val | Rest], Values, _, NewValues) :-
    process_map(Op, Val, Values, NewValues),
    process_commands(Rest, [], _, RemainingValues),
    append(NewValues, RemainingValues, Result).
process_commands(['filter', Op, Val | Rest], Values, _, NewValues) :-
    process_filter(Op, Val, Values, NewValues),
    process_commands(Rest, [], _, RemainingValues),
    append(NewValues, RemainingValues, Result).
process_commands(['reduce', Op, Val | Rest], Values, _, Result) :-
    process_reduce(Op, Val, Values, Result),
    process_commands(Rest, [], _, []).

process_map(add, Val, Values, NewValues) :-
    maplist(lambda(X, X + Val), Values, NewValues).
process_map(mul, Val, Values, NewValues) :-
    maplist(lambda(X, X * Val), Values, NewValues).

process_filter(even, _, Values, NewValues) :-
    keep_if(lambda(X, X mod 2 =:= 0), Values, NewValues).
process_filter(odd, _, Values, NewValues) :-
    keep_if(lambda(X, X mod 2 \= 0), Values, NewValues).
process_filter(greater, Val, Values, NewValues) :-
    keep_if(lambda(X, X > Val), Values, NewValues).

process_reduce(sum, _, Values, Result) :-
    sum_list(Values, Result).
process_reduce(max, _, Values, Result) :-
    max_list(Values, Result).

print_result([]) :- !.
print_result(Result) :-
    format('~w~n', [Result]).

number_string(N, S) :-
    atom_number(S, N).
