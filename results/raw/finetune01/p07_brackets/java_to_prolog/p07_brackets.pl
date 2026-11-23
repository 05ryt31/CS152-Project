:- use_module(library(clpfd)).
 
balanced_parentheses :-
	Lines = ["([]){}", "{[()]}", "[{()}]", "([)]", "({)}", "(({{}}))"],
	maplist(check_balance, Lines).
 
check_balance(Line) :-
	atom_chars(Line, Chars),
	length(Chars, Len),
	Len #= 2 * N,
	N #>= 0,
	balance(N, Chars, []).
 
balance(0, [], []) :- !.
balance(N, [C|T], S) :-
	C \= ')', C \= ']', C \= '}', balance(N, T, S), !.
balance(N, [C|T], S) :-
	member(C, ['(', '[', '{']),
	N1 #= N + 1,
	balance(N1, T, [C|S]).
balance(N, [C|T], S) :-
	member(C, [')', ']', '}']),
	N1 #= N - 1,
	member(D, ['(', '[', '{']),
	reverse([D|_], S),
	balance(N1, T, S).
 
