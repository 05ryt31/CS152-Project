:- use_module(library(readutil)).

pairs([")"-"(","], ["]"-"["], ["}"-"{"]).

balanced(Text) :-
    string_chars(Text, Chars),
    balanced_chars(Chars, []).

balanced_chars([], []).
balanced_chars([H|T], Stack) :-
    member(H-Open, pairs()),
    append(Stack, [Open], NewStack),
    balanced_chars(T, NewStack).
balanced_chars([H|T], Stack) :-
    member(H-Close, pairs()),
    Stack = [Close|_],
    balanced_chars(T, Stack).

p07_brackets :-
    read_line_to_string(current_input, N),
    number_codes(N, Number),
    between(1, Number, _),
    repeat,
        read_line_to_string(current_input, Line),
        Line \= "",
        (   balanced(Line) -> format('yes~n')
        ;   format('no~n')
        ),
        fail,
    !,
    halt.
