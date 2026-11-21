:- use_module(library(readutil)).
:- use_module(library(lists)).

p06_calc :-
    read_line_to_string(current_input, Input),
    parse(Input, Result),
    format('~d~n', [Result]),
    halt.

parse(Text, Result) :-
    parser(Text, Tokens),
    phrase(expression(Tokens), Tokens, []),
    !,
    Result = Tokens.

parser(Text, Tokens) :-
    atom_codes(Text, Codes),
    split_tokens(Codes, Tokens).

split_tokens([], []).
split_tokens([H|T], Tokens) :-
    whitespace(H), !,
    split_tokens(T, Tokens).
split_tokens([H|T], [Token|Tokens]) :-
    digit(H), !,
    number(H, T, Number),
    atom_codes(Token, Number),
    split_tokens(T, Tokens).
split_tokens([H|T], [Token|Tokens]) :-
    \+ whitespace(H), \+ digit(H), !,
    Token = [H],
    split_tokens(T, Tokens).

whitespace(' ').
whitespace('\t').
whitespace('\n').

digit('0').
digit('1').
digit('2').
digit('3').
digit('4').
digit('5').
digit('6').
digit('7').
digit('8').
digit('9').

number(_, [], []) :- !.
number(H, [H2|T], [H|Number]) :-
    digit(H2), !,
    number(H2, T, Number).

expression([H|T], Result) :-
    term(H, T, Right, Rest),
    expression(Rest, Right, Result).

expression([H|_], Right, Result) :-
    H = '+', !,
    term('+', _, Left, Rest),
    expression(Rest, Left, Result).
expression([H|_], Right, Result) :-
    H = '-', !,
    term('-', _, Left, Rest),
    expression(Rest, -Left, Result).
expression([], Right, Right).

term([H|T], Result) :-
    factor(H, T, Right, Rest),
    term(Rest, Right, Result).

term([], Right, Right) :-
    !.

factor([H|T], Result) :-
    H = '(', !,
    expression(T, Right, Rest),
    Rest = [')'], !,
    term(Rest, Right, Result).

factor([H|T], Result) :-
    number(H, T, Number),
    atom_codes(Result, Number).
