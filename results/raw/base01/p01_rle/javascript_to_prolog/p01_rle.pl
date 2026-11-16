:- use_module(library(lists)).
:- use_module(library(readutil)).

p01_rle :-
    read_line_to_string(current_input, Line),
    process_line(Line, Result),
    format('~s~n', [Result]),
    halt.

process_line([], []).
process_line([H|T], Result) :-
    count_chars(T, H, Count),
    append([H, Count], Rest, Result),
    process_line(Rest, _).

count_chars([], _, 0).
count_chars([H|T], C, Count) :-
    (   H = C -> Count1 is Count + 1, count_chars(T, C, Count1)
    ;   Count is 1
    ).
