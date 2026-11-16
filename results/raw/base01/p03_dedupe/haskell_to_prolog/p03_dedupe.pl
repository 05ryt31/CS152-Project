:- use_module(library(lists)).
:- use_module(library(readutil)).

p03_dedupe :-
    read_line_to_string(current_input, Line),
    string_codes(Line, Codes),
    atom_codes(Atom, Codes),
    split_string(Atom, " ", "", NumStrings),
    maplist(atom_number, NumStrings, Numbers),
    unique(Numbers, UniqueNumbers),
    (   UniqueNumbers \= []
    ->  format("~w~n", [UniqueNumbers])
    ;   true
    ),
    halt.

unique([], []).
unique([X|Xs], [X|Ys]) :-
    member(X, Xs), !,
    unique(Xs, Ys).
unique([X|Xs], [X|Ys]) :-
    unique(Xs, Ys).

atom_number(A, N) :-
    number_codes(N, A).
