:- use_module(library(readutil)).

p06_calc :-
    read_line_to_string(current_input, Text),
    Tokens = Tokens,
    parse(Tokens, Result),
    format('~d~n', [Result]),
    halt(0).

parse(Tokens, Result) :-
    Parser =.. [Parser, Tokens, 0],
    Parser:expression(Result).

tokenize(Text, Tokens) :-
    tokenize(Text, [], Tokens).

tokenize([], Acc, Tokens) :-
    reverse(Acc, Tokens).
tokenize([H|T], Acc, Tokens) :-
    H = ' ',
    !,
    tokenize(T, Acc, Tokens).
tokenize([H|T], Acc, Tokens) :-
    digit(H),
    !,
    tokenize_digits(T, [H|Acc], Tokens).
tokenize([H|T], [H|Acc], Tokens) :-
    tokenize(T, Acc, Tokens).

digit(C) :-
    C >= '0',
    C =< '9'.

tokenize_digits([], Acc, Tokens) :-
    reverse(Acc, Tokens).
tokenize_digits([H|T], Acc, Tokens) :-
    digit(H),
    !,
    tokenize_digits(T, [H|Acc], Tokens).
tokenize_digits(_, Acc, Tokens) :-
    reverse(Acc, Tokens).

expression(Parser, Value) :-
    Parser:term(Value1),
    Parser:peek(Op),
    Op \= nil,
    Parser:next,
    expression(Parser, Value2),
    (   Op = '+'
    ->  Value is Value1 + Value2
    ;   Op = '-'
    ->  Value is Value1 - Value2
    ).

term(Parser, Value) :-
    Parser:factor(Value1),
    Parser:peek(Op),
    Op = '*',
    Parser:next,
    term(Parser, Value2),
    Value is Value1 * Value2.

term(Parser, Value) :-
    Parser:factor(Value).

factor(Parser, Value) :-
    Parser:peek('('),
    Parser:next,
    Parser:expression(Value),
    Parser:peek(')'),
    Parser:next.

factor(Parser, Value) :-
    Parser:next(Token),
    number(Token),
    Value is Token.

number(Token) :-
    atom_number(Token, _).
