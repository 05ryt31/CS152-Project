:- use_module(library(clpfd)).
 
balanced_parentheses :-
	Lines = ["([]){}", "([)]", "{[(])}", "{{{{}}}}"],
	maplist(check_balance, Lines).
 
check_balance(Line) :-
	atom_chars(Line, Chars),
	length(Chars, Len),
	Len #> 0,
	% Create a list of brackets
	bracket_list(Chars, Brackets),
	% Find the balance of each bracket
	balance(Brackets, Balance),
	% Check if all brackets are balanced
	all_distinct(Balance).
 
bracket_list([], []).
bracket_list([C|T], [B|BT]) :-
	is_bracket(C, B),
	bracket_list(T, BT).
 
is_bracket(')', '(').
is_bracket(']', '[').
is_bracket('}', '{').
 
balance([], []).
balance([B|T], [BB|TB]) :-
	% If it is a closing bracket, then BB is 1 otherwise 0
	(   B == ')' ; B == ']' ; B == '}' ) -> BB #= 1; BB #= 0,
	% Add the current bracket to the sum of the previous ones
	sum(Balance, BB, NB),
	% Continue balancing the rest of the brackets
	balance(T, TB),
	% The next balance is the current balance minus the current bracket
	NB #= TB - BB.
 
