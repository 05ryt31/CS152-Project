:- use_module(library(readutil)).

tokens([], []) :- !.
tokens([C|Cs], Tokens) :-
    C == ' ', !,
    tokens(Cs, Tokens).
tokens([C|Cs], [Token|Tokens]) :-
    member(C, "+-*()"), !,
    Token = [C],
    tokens(Cs, Tokens).
tokens([C|Cs], [Digit|Tokens]) :-
    digit_char(C), !,
    append(Digits, [C], Digit),
    tokens(Cs, Digits).

digit_char(C) :-
    C >= '0', C =< '9'.

parse_expression(P, Result) :-
    parse_term(P, X, Rest1),
    parse_adds(X, Rest1, Rest2),
    Result = X.

parse_adds(X, [], Rest, Rest) :-
    !.
parse_adds(X, ["+"|Rest1], Rest2, Rest3) :-
    parse_term(Rest1, Y, Rest2),
    NewX is X + Y,
    parse_adds(NewX, Rest2, Rest3).
parse_adds(X, ["-"|Rest1], Rest2, Rest3) :-
    parse_term(Rest1, Y, Rest2),
    NewX is X - Y,
    parse_adds(NewX, Rest2, Rest3).

parse_term(P, Result) :-
    parse_factor(P, X, Rest1),
    parse_muls(X, Rest1, Rest2),
    Result = X.

parse_muls(X, [], Rest, Rest) :-
    !.
parse_muls(X, ["*"|Rest1], Rest2, Rest3) :-
    parse_factor(Rest1, Y, Rest2),
    NewX is X * Y,
    parse_muls(NewX, Rest2, Rest3).

parse_factor(["("|Rest], Result) :-
    parse_expression(Rest, X, ")":Rest1),
    Result = X.

parse_factor([X|Rest], Result, Rest) :-
    number_chars(Result, [X]).

p06_calc :-
    read_line_to_string(current_input, Line),
    parse_expression(tokens(Line), Result),
    format('~d~n', [Result]),
    halt(0).
