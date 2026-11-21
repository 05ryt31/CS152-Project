:- use_module(library(lists)).
:- use_module(library(readutil)).

% Entry point of the program
p15_permutations :-
    read_line_to_string(current_input, Line),
    Perms =.. [permutations, Line],
    SortedPerms = sort(Perms),
    format('~w~n', [SortedPerms]),
    halt.

% Predicate to generate all permutations of a list
permutations([]) --> [[]].
permutations(XS) -->
    { picks(XS, Pairs) },
    pairs_to_perms(Pairs).

% Helper predicate to convert pairs to permutations
pairs_to_perms([]) --> [].
pairs_to_perms([(Y, YS)|Pairs]) -->
    { permutations(YS, RestPerms) },
    [[Y|Rest]|RestPerms].

% Predicate to generate all possible pairs of an element and the rest of the list
picks([], []) :- !.
picks([X|XS], [(X, XS)|Pairs]) :-
    picks(XS, Pairs).
