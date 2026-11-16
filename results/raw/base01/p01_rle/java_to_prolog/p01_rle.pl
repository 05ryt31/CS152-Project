:- use_module(library(lists)).
:- use_module(library(readutil)).

p01_rle :-
    read_line_to_string(current_input, Line),
    process_rle(Line, Result),
    format('~s~n', [Result]),
    halt(0).

process_rle([], []).
process_rle(Text, Result) :-
    process_rle(Text, [], Result).

process_rle([H|T], Acc, Result) :-
    count_chars(H, T, Count, Rest),
    append(Acc, [H, Count], NewAcc),
    process_rle(Rest, NewAcc, Result).

count_chars(_, [], 0, []).
count_chars(Char, [Char|Rest], N, Rest) :-
    !,
    M is N + 1,
    count_chars(Char, Rest, M, Rest).
count_chars(_, [_|_], 0, _).
