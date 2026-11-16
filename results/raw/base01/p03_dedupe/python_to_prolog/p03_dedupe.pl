:- use_module(library(lists)).
:- use_module(library(readutil)).

p03_dedupe :-
    read_line_to_string(current_input, Line),
    split_string(Line, Tokens, ' '),
    maplist(string_to_integer, Tokens, Integers),
    remove_duplicates(Integers, Unique),
    (   Unique \= []
    ->  format("~w~n", [Unique])
    ;   true
    ),
    halt(0).

remove_duplicates([], []).
remove_duplicates([H|T], [H|R]) :-
    \+ member(H, T),
    remove_duplicates(T, R).
remove_duplicates([_|T], R) :-
    remove_duplicates(T, R).

string_to_integer(S, I) :-
    number_string(I, S).
