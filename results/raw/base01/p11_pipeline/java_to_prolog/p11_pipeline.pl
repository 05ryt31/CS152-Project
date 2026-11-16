:- use_module(library(lists)).
:- use_module(library(readutil)).

p11_pipeline :-
    read_line_to_string(current_input, Line),
    split_string(Line, ' ', '', Tokens),
    maplist(string_to_integer, Tokens, Values),

    read_line_to_string(current_input, KLine),
    string_to_integer(KLine, K),

    process_commands(Values, K, Result),

    print_result(Result),
    halt.

process_commands(_, 0, _).

process_commands(Values, K, Result) :-
    read_line_to_string(current_input, Command),
    parse_command(Command, Action, Arg1, Arg2),
    update_values(Values, Action, Arg1, Arg2, NewValues),
    K1 is K - 1,
    process_commands(NewValues, K1, Result).

parse_command(Command, Action, Arg1, Arg2) :-
    split_string(Command, ' ', '', Parts),
    nth0(0, Parts, Action),
    nth0(1, Parts, Arg1),
    nth0(2, Parts, Arg2).

update_values(Values, 'map', 'add', Amount, NewValues) :-
    maplist(add_amount(Amount), Values, NewValues).
update_values(Values, 'map', 'mul', Amount, NewValues) :-
    maplist(mul_amount(Amount), Values, NewValues).
update_values(Values, 'filter', 'even', _, NewValues) :-
    keep_if_even(Values, NewValues).
update_values(Values, 'filter', 'odd', _, NewValues) :-
    keep_if_odd(Values, NewValues).
update_values(Values, 'filter', 'gt', Threshold, NewValues) :-
    keep_if_gt(Values, Threshold, NewValues).
update_values(Values, 'sum', _, _, Sum) :-
    sum_list(Values, Sum).
update_values(Values, 'max', _, _, Max) :-
    find_max(Values, Max).

add_amount(Amount, Value, NewValue) :-
    NewValue is Value + Amount.

mul_amount(Amount, Value, NewValue) :-
    NewValue is Value * Amount.

keep_if_even([], []).
keep_if_even([H|T], [H|NT]) :-
    H mod 2 =:= 0,
    keep_if_even(T, NT).
keep_if_even([_|T], NT) :-
    keep_if_even(T, NT).

keep_if_odd([], []).
keep_if_odd([H|T], [H|NT]) :-
    H mod 2 =\= 0,
    keep_if_odd(T, NT).
keep_if_odd([_|T], NT) :-
    keep_if_odd(T, NT).

keep_if_gt([], _, []).
keep_if_gt([H|T], Threshold, [H|NT]) :-
    H > Threshold,
    keep_if_gt(T, Threshold, NT).
keep_if_gt([_|T], Threshold, NT) :-
    keep_if_gt(T, Threshold, NT).

print_result(List) :-
    maplist(print_number, List),
    nl.
print_result(Sum) :-
    format('~d~n', [Sum]).
print_result(Max) :-
    format('~d~n', [Max]).

print_number(Number) :-
    write(Number),
    write(' ').
