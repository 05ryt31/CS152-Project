:- use_module(library(lists)).
:- use_module(library(readutil)).

parse_line(Line, Values) :-
    atom_codes(Line, Codes),
    split_string(Codes, " ", "", Tokens),
    maplist(atom_number, Tokens, Values).

p02_merge_sorted :-
    read_line_to_string(current_input, LineA),
    parse_line(LineA, A),
    read_line_to_string(current_input, LineB),
    parse_line(LineB, B),
    merge(A, B, Merged),
    format("~w~n", [Merged]),
    halt.

merge([], B, B).
merge(A, [], A).
merge([H1|T1], [H2|T2], [H1|Merged]) :-
    H1 =< H2,
    merge(T1, [H2|T2], Merged).
merge([H1|T1], [H2|T2], [H2|Merged]) :-
    H1 > H2,
    merge([H1|T1], T2, Merged).
