:- use_module(library(lists)).
:- use_module(library(readutil)).

balanced(Text) :-
    Text = '',
    !,
    true.
balanced(Text) :-
    findall(Char, member(Char, Text), Chars),
    balanced_stack(Chars).

balanced_stack([]).
balanced_stack([H|T]) :-
    H = '(',
    balanced_stack(T).
balanced_stack([H|T]) :-
    H = '[',
    balanced_stack(T).
balanced_stack([H|T]) :-
    H = '{',
    balanced_stack(T).
balanced_stack([H|T]) :-
    H = ')',
    T = [L|_],
    L = '(',
    balanced_stack(T).
balanced_stack([H|T]) :-
    H = ']',
    T = [L|_],
    L = '[',
    balanced_stack(T).
balanced_stack([H|T]) :-
    H = '}',
    T = [L|_],
    L = '{',
    balanced_stack(T).

p07_brackets :-
    read_line_to_string(current_input, Line),
    atom_number(Line, N),
    between(1, N, _),
    repeat,
        read_line_to_string(current_input, Line),
        (   balanced(Line)
        ->  format('yes~n')
        ;   format('no~n')
        ),
        !,
        fail,
    true.

:- initialization(p07_brackets).
:- halt.
