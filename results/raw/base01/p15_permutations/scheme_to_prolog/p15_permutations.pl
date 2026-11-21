:- use_module(library(lists)).
:- use_module(library(readutil)).

remove_first(_, [], []) :- !.
remove_first(X, [X | T], T) :- !.
remove_first(X, [H | T], [H | RT]) :-
    remove_first(X, T, RT).

generate([], _) :-
    format('~n'), !.
generate([H | T], Remaining) :-
    generate(Remaining, NewRemaining),
    remove_first(H, NewRemaining, RemainingNew),
    generate(NewRemaining, RemainingNew),
    format('~c', [H]),
    nl,
    !.

p15_permutations :-
    read_line_to_string(current_input, Line),
    Letters =.. [string | Line],
    SortedLetters = sort(Letters),
    generate(SortedLetters, SortedLetters),
    halt(0).
