:- use_module(library(lists)).
:- use_module(library(readutil)).

p12_group_by :-
    read_line_to_string(current_input, N),
    string_to_number(N, NumRows),
    findall(Line, read_line_to_string(current_input, Line), Lines),
    process_rows(Lines, Result),
    maplist(write_row, Result),
    nl,
    halt.

process_rows([], []).
process_rows(Rows, Result) :-
    group_by_key(Rows, Groups),
    maplist(show_group, Groups, Result).

group_by_key([], []).
group_by_key([Row | Rows], [Key-Value | Rest]) :-
    split_string(Row, " ", "", [Key, Value]),
    number(Value, Number),
    group_by_key(Rows, Rest1),
    insert_or_update(Key, Number, Rest1, Key-Value, Rest).

insert_or_update(_, _, [], New, [New]).
insert_or_update(Key, Number, [Key-Old | Rest], New, [Key-(Sum, Count) | Rest]) :-
    sum_and_count(Number, Old, Sum, Count).
insert_or_update(Key, Number, [Other | Rest], New, [Other | Rest1]) :-
    insert_or_update(Key, Number, Rest, New, Rest1).

sum_and_count(New, Old, Sum, Count) :-
    Sum is New + Old,
    Count is 1 + Old.

show_group(Key-Value, Row) :-
    format('~w ~d ~d~n', [Key, Value, Value]).

write_row(Row) :-
    write(Row),
    nl.
