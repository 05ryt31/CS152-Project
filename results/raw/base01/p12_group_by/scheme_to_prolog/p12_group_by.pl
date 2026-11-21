:- use_module(library(lists)).
:- use_module(library(readutil)).

p12_group_by :-
    read_line_to_string(current_input, N),
    number_codes(N, Number),
    read_groups(Number, Groups),
    print_groups(Groups),
    halt.

read_groups(0, []) :- !.
read_groups(N, Groups) :-
    read_line_to_string(current_input, Line),
    split_string(Line, "", " ", Parts),
    [Key, Value] = Parts,
    number_codes(Value, Number),
    update(Key, Number, [], NewGroups),
    M is N - 1,
    read_groups(M, NewGroups).

update(Key, Value, [], [(Key, Value, 1)]) :- !.
update(Key, Value, [(K, V, C)|T], Result) :-
    Key == K,
    !,
    NewValue is V + Value,
    NewCount is C + 1,
    Result = [(K, NewValue, NewCount)|T].
update(Key, Value, [(K, V, C)|T], [(K, V, C)|Result]) :-
    update(Key, Value, T, Result).

print_groups([]) :- !.
print_groups([(Key, Value, Count)|T]) :-
    format('~w ~w ~w~n', [Key, Value, Count]),
    print_groups(T).
