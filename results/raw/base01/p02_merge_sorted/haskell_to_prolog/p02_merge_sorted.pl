:- use_module(library(lists)).
:- use_module(library(readutil)).

read_nums(S, L) :-
    atom_codes(S, Codes),
    split_string(Codes, " ", "", Words),
    maplist(atom_number, Words, L).

merge([], YS, YS).
merge(XS, [], XS).
merge([X|XS], [Y|YS], [X|M]) :-
    X =< Y,
    merge(XS, [Y|YS], M).
merge([X|XS], [Y|YS], [Y|M]) :-
    X > Y,
    merge([X|XS], YS, M).

safe_get_line(Input, Line) :-
    at_end_of_stream(Input), !,
    Line = "".
safe_get_line(_, Line) :-
    read_line_to_string(current_input, Line).

p02_merge_sorted :-
    safe_get_line(current_input, A),
    safe_get_line(current_input, B),
    read_nums(A, LA),
    read_nums(B, LB),
    merge(LA, LB, Result),
    (   Result \= []
    ->  format("~w~n", [Result])
    ;   true
    ),
    halt(0).
