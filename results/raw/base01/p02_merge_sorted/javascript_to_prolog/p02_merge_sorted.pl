:- use_module(library(lists)).
:- use_module(library(readutil)).

parse_line(Line, Numbers) :-
    atom_codes(Line, Codes),
    split_string(Codes, " ", "", Tokens),
    maplist(atom_number, Tokens, Numbers).

p02_merge_sorted :-
    read_line_to_string(current_input, Line1),
    parse_line(Line1, A),
    read_line_to_string(current_input, Line2),
    parse_line(Line2, B),
    merge_sorted(A, B, Result),
    format('~w~n', [Result]),
    halt.

merge_sorted([], B, B).
merge_sorted(A, [], A).
merge_sorted([H1|T1], [H2|T2], [H1|Result]) :-
    H1 =< H2,
    merge_sorted(T1, [H2|T2], Result).
merge_sorted([H1|T1], [H2|T2], [H2|Result]) :-
    H1 > H2,
    merge_sorted([H1|T1], T2, Result).
