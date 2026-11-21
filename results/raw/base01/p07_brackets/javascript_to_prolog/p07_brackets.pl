:- use_module(library(lists)).
:- use_module(library(readutil)).

pairs([')'-'(',']-'[','}'-'{']).

balanced(Text) :-
    stack(Text, []).

stack([], []).
stack([H|T], Stack) :-
    member(H-Pairs, pairs),
    stack(T, [Pairs|Stack]).
stack([H|T], [Top|Stack]) :-
    H == Top,
    stack(T, Stack).

p07_brackets :-
    read_lines(InputLines),
    nth0(0, InputLines, N),
    maplist(balanced_and_print, InputLines, N),
    halt.

read_lines(InputLines) :-
    read_string(current_input, '\n', '', Lines),
    split_string(Lines, '\n', '', InputLines).

balanced_and_print(Line, N) :-
    nth0(N, Line, Text),
    (   balanced(Text) -> format('yes~n')
    ;   format('no~n') ).

:- initialization(p07_brackets).
