:- use_module(library(lists)).
:- use_module(library(readutil)).

numbers(Line, Numbers) :-
    Line = "",
    Numbers = [] ;
    split_string(Line, " ", "", Tokens),
    maplist(string_number, Tokens, Numbers).

string_number(String, Number) :-
    number_string(Number, String).

merge([], B, B).
merge(A, [], A).
merge([H1|T1], [H2|T2], [H1|Result]) :-
    H1 =< H2,
    merge(T1, [H2|T2], Result).
merge([H1|T1], [H2|T2], [H2|Result]) :-
    H1 > H2,
    merge([H1|T1], T2, Result).

print_list([]).
print_list([H|T]) :-
    format('~d', [H]),
    print_list(T).

safe_read_line(Input) :-
    read_line_to_string(current_input, Input),
    Input \= end_of_file.

p02_merge_sorted :-
    safe_read_line(Line1),
    numbers(Line1, List1),
    safe_read_line(Line2),
    numbers(Line2, List2),
    merge(List1, List2, Merged),
    print_list(Merged),
    nl,
    halt(0).
