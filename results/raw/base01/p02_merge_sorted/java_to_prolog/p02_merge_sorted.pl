:- use_module(library(lists)).
:- use_module(library(readutil)).

parse(Line, Values) :-
    Line \= '',
    atom_codes(Line, Codes),
    split_string(Codes, ' ', '', Parts),
    maplist(atom_number, Parts, Values).

p02_merge_sorted :-
    read_line_to_string(current_input, ALine),
    parse(ALine, A),
    read_line_to_string(current_input, BLine),
    parse(BLine, B),
    merge(A, B, Result),
    format('~w~n', [Result]),
    halt.

merge([], B, B).
merge(A, [], A).
merge([H1|T1], [H2|T2], [H1|Result]) :-
    H1 =< H2,
    merge(T1, [H2|T2], Result).
merge([H1|T1], [H2|T2], [H2|Result]) :-
    H1 > H2,
    merge([H1|T1], T2, Result).
