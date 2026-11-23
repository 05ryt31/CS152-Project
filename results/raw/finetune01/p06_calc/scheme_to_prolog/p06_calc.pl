:- use_module(library(lambda)).
 
% parse expression into list of terms
parse_expr(S, L) :-
	expr(S, [], L).
 
expr(S, L, R) :-
	(   term(S, T, S1), expr1(S1, T, L, L1),
	    ! ; T = [], R = L1 ).
 
expr1([], T, L, L).
expr1(S, T, L, R) :-
	op(Op, _, _),
	token(Op, S, S1),
	expr(S1, [Op,T|L], R).
 
term(S, T, S1) :-
	number(T, S, S1).
term(S, T, S1) :-
	variable(T, S, S1).
term(S, T, S1) :-
	parentheses(T, S, S1).
 
variable([H|T], V, S) :-
	char_type(H, alpha),
	name(V, [H|V1]),
	variable(T, V1, S).
variable([], V, V).
 
parentheses(T, S, S1) :-
	token('(', S, S2),
	expr(S2, [], T1),
	token(')', T1, S1).
 
number(N, S, S1) :-
	number_chars(N, [48,49,50,51,52,53,54,55,56,57]),
	number_chars(N, S),
	string_concat(_, [N|_], S1).
 
 
% evaluate parsed expression
eval(L, N) :-
	evaluate(L, 0, N).
 
evaluate([], N, N).
evaluate([+,-,A,B], N, R) :-
	evaluate(A, N, M),
	evaluate(B, M, R).
evaluate([*,A,B], N, R) :-
	evaluate(A, N, M),
	evaluate(B, M, R).
evaluate([A], N, R) :-
	evaluate(A, N, R).
evaluate(number(N), N, N).
evaluate(variable(V), N, R) :-
	bagof((X,Y), var(V,X), [(N,Y)]),
	member((N,R), Y).
evaluate(parens(P), N, R) :-
	evaluate(P, N, R).
 
 
% calculate
calc(S, N) :-
	parse_expr(S, L),
	evaluate(L, N).
 
