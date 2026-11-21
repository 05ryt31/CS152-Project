:- use_module(library(lists)).
:- use_module(library(readutil)).

p03_dedupe :-
    read_line_to_string(current_input, Line),
    trim(Line, Trimmed),
    split_string(Trimmed, " ", "", Tokens),
    maplist(number_string, Tokens, Numbers),
    remove_duplicates(Numbers, UniqueNumbers),
    (   UniqueNumbers \= []
    ->  format('~w~n', [UniqueNumbers])
    ;   true
    ),
    halt.

remove_duplicates([], []).
remove_duplicates([H|T], [H|R]) :-
    \+ member(H, T),
    remove_duplicates(T, R).

trim(String, Trimmed) :-
    atom_codes(String, Codes),
    delete(Codes, 32, TrimmedCodes),
    atom_codes(Trimmed, TrimmedCodes).
