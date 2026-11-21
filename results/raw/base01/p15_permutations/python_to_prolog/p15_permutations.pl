:- use_module(library(lists)).
:- use_module(library(readutil)).

generate(_, _, [], Out, Out).
generate(Letters, Used, Current, Out, Acc) :-
    length(Current, Len),
    Len < length(Letters),
    find_unused_index(Letters, Used, Index),
    NewUsed = [New | Rest],
    nth0(Index, Letters, Letter),
    New = true,
    append(Current, [Letter], NewCurrent),
    generate(Letters, NewUsed, NewCurrent, Out, Acc).

find_unused_index([], _, _).
find_unused_index([H|T], [false|_], 0).
find_unused_index([_|T], [_|U], N) :-
    find_unused_index(T, U, M),
    M > 0,
    N is M + 1.

p15_permutations :-
    read_line_to_string(current_input, Line),
    atom_codes(Line, Codes),
    split_string(Codes, "", " ", Letters),
    sort(Letters, SortedLetters),
    generate(SortedLetters, [false|Rest], [], Results, []),
    maplist(atom_codes, Results, ResultCodes),
    maplist(write, ResultCodes),
    nl,
    halt.
