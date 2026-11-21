:- use_module(library(lists)).
:- use_module(library(readutil)).

p15_permutations :-
    read_string(current_input, _, Input),
    String =.. [string, Input],
    Chars = sort(String),
    Permutations = [],
    findall(Permutation, permute(Chars, [], Permutation), Permutations),
    maplist(writeln, Permutations),
    halt.

permute([], Prefix, Prefix).
permute([H|T], Prefix, Perm) :-
    append(NewPrefix, [H], Prefix),
    permute(T, NewPrefix, Perm).

:- initialization(p15_permutations).
