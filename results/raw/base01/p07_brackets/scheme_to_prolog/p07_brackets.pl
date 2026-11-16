:- use_module(library(lists)).
:- use_module(library(readutil)).

matching_opener_closer(Opener, Closer) :-
    (   Opener = '(' , Closer = ')' ;
        Opener = '[' , Closer = ']' ;
        Opener = '{' , Closer = '}' ).

balanced_text(Text) :-
    string_to_list(Text, Chars),
    balanced_chars(Chars, []).

balanced_chars([], []).
balanced_chars([H|T], Stack) :-
    (   matching_opener_closer(H, C) ->
        balanced_chars(T, [C|Stack])
    ;   H = '(' -> false ;
        H = '[' -> false ;
        H = '{' -> false ;
        Stack = [_|_] ->
            pop(Stack, _, NewStack),
            matching_opener_closer(Pop, H),
            balanced_chars(T, NewStack)
        ;   false
    ).

pop([_ | T], Head, T).

p07_brackets :-
    read_line_to_string(current_input, N),
    number_string(Number, N),
    between(1, Number, _),
    repeat,
        read_line_to_string(current_input, Line),
        (   balanced_text(Line) ->
            format('yes~n')
        ;   format('no~n')
        ),
        !,
        fail.

:- initialization(p07_brackets).
:- halt.
