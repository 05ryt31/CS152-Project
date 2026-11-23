 
:- use_module(library(lambda)).
 
% parse the string into a list of tokens
parse(S, Tokens) :-
	string_chars(S, Cs),
	atom_chars(A, Cs),
	atomic_list_concat(Tokens, A).
 
% evaluate the parsed list of tokens
eval(Tokens, Result) :-
	evaluate(Tokens, [], Result).
 
evaluate([], R, R).
evaluate([+|T], S, R) :- !,
	evaluate(T, [+(S), +(R)], R).
evaluate([-|T], S, R) :- !,
	evaluate(T, [-+(S), +(R)], R).
evaluate([*|T], S, R) :- !,
	evaluate(T, [*+(S), +(R)], R).
evaluate([/|T], S, R) :- !,
	evaluate(T, [/+(S), +(R)], R).
evaluate(['('|T], S, R) :- !,
	evaluate(T, S, V),
	evaluate(Rest, [V|S], R).
evaluate([')'|T], S, R) :- !,
	evaluate(T, S, R).
evaluate([N|T], S, R) :-
	number(N),
	evaluate(T, [N|S], R).
evaluate([Op|T], S, R) :-
	call(Op, N),
	evaluate(T, [N|S], R).
 
% convert infix notation to postfix notation
infix_postfix(Infix, Postfix) :-
	infix_postfix(Infix, [], Postfix).
 
infix_postfix([], P, P).
infix_postfix([+|T], S, P) :-
	length(S, L),
	L > 1,
	pop(S, S1, Op),
	infix_postfix(T, [Op|S1], P).
infix_postfix([-|T], S, P) :-
	length(S, L),
	L > 1,
	pop(S, S1, Op),
	infix_postfix(T, [Op|S1], P).
infix_postfix([*|T], S, P) :-
	length(S, L),
	L > 1,
	pop(S, S1, Op),
	infix_postfix(T, [Op|S1], P).
infix_postfix([/|T], S, P) :-
	length(S, L),
	L > 1,
	pop(S, S1, Op),
	infix_postfix(T, [Op|S1], P).
infix_postfix(['('|T], S, P) :-
	infix_postfix(T, S, P).
infix_postfix([')'|_], _, _).
infix_postfix([N|T], S, P) :-
	number(N),
	infix_postfix(T, [N|S], P).
infix_postfix([Op|T], S, P) :-
	infix_postfix(T, S, Q),
	append(Q, [Op], P).
 
% calculate the result using the shunting yard algorithm
calculate(S, Result) :-
	parse(S, Tokens),
	infix_postfix(Tokens, Postfix),
	evaluate(Postfix, Result).
 
