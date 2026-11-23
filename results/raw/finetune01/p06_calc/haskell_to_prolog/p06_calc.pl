 
:- use_module(library(lambda)).
 
% Parser
tokenize(Tokens, Expression) :-
	expression(Expression, Tokens).
 
expression([Token|Tokens], Result) :-
	term(Token, Terms),
	expression(Terms, Result, Token, Tokens).
 
expression([], Result, _, []) :- !.
expression([+|Tokens], Result, Term, Rest) :-
	term(Term, Terms),
	expression(Terms, Result1, Term, Tokens),
	!,
	expression(+, Result1, Result, Rest).
expression([-|Tokens], Result, Term, Rest) :-
	term(Term, Terms),
	expression(Terms, Result1, Term, Tokens),
	!,
	expression(-, Result1, Result, Rest).
 
term([Token|Tokens], Result) :-
	factor(Token, Terms),
	term(Terms, Result, Token, Tokens).
 
term([], Result, _, []) :- !.
term([*|Tokens], Result, Factor, Rest) :-
	factor(Factor, Terms),
	term(Terms, Result1, Factor, Tokens),
	!,
	term(*, Result1, Result, Rest).
term([/|Tokens], Result, Factor, Rest) :-
	factor(Factor, Terms),
	term(Terms, Result1, Factor, Tokens),
	!,
	term(/, Result1, Result, Rest).
 
factor([Token|Tokens]) :-
	number(Token),
	!,
	factor(Token, Tokens).
factor([Token|Tokens]) :-
	Token = '(',
	expression(Tokens, Result, _, Rest),
	Token1 = ')',
	append(Result, [Token1], Tokens).
 
factor(Number, []) :-
	number(Number).
factor(Number, [_]).
 
number(Number) :-
	member(Number, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).
 
% Calculator
calculate(Expression, Result) :-
	tokenize(Tokens, Expression),
	expression(Tokens, Result).
 
expression([Token|Tokens], Result) :-
	term(Token, Terms),
	expression(Terms, Result, Token, Tokens).
 
expression([], Result, _, []) :- !.
expression([+|Tokens], Result, Term, Rest) :-
	term(Term, Terms),
	expression(Terms, Result1, Term, Tokens),
	!,
	expression(+, Result1, Result, Rest).
expression([-|Tokens], Result, Term, Rest) :-
	term(Term, Terms),
	expression(Terms, Result1, Term, Tokens),
	!,
	expression(-, Result1, Result, Rest).
 
term([Token|Tokens], Result) :-
	factor(Token, Terms),
	term(Terms, Result, Token, Tokens).
 
term([], Result, _, []) :- !.
term([*|Tokens], Result, Factor, Rest) :-
	factor(Factor, Terms),
	term(Terms, Result1, Factor, Tokens),
	!,
	term(*, Result1, Result, Rest).
term([/|Tokens], Result, Factor, Rest) :-
	factor(Factor, Terms),
	term(Terms, Result1, Factor, Tokens),
	!,
	term(/, Result1, Result, Rest).
 
factor(Number, Number) :-
	number(Number).
factor(Token, Number) :-
	Token = '(',
	calculate(Token, Number).
 
% Main
calc :-
	read_line_to_string(user_input, Line),
	calculate(Line, Result),
	writeln(Result).
 
