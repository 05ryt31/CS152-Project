:- use_module(library(lists)).
:- use_module(library(readutil)).

generate(_, [], _).

generate(Letters, Used, Current) :-
    length(Current, Length),
    Length =:= length(Letters), !,
    format('~s~n', [Current]).

generate(Letters, Used, Current) :-
    findall(Index, (between(0, Length, Index), \+ nth0(Index, Used, true)), Indices),
    member(Index, Indices),
    nth0(Index, Letters, Letter),
    nth0(Index, Used, _, NewUsed),
    string_concat(Current, [Letter], NewCurrent),
    generate(Letters, NewUsed, NewCurrent).

p15_permutations :-
    read_line_to_string(current_input, Line),
    atom_codes(Line, Codes),
    sort(Codes, SortedCodes),
    generate(SortedCodes, maplist(=(false), SortedCodes), []),
    halt.
