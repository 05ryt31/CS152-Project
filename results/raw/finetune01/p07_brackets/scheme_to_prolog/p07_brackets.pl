:- use_module(library(clpfd)).
 
% Brackets matching
match_brackets(S):-
	length(S,L),
	(   L mod 2 =:= 0 ->
		stack_brackets(S,[])
	;   otherwise -> false
	).
 
stack_brackets([],_):-!.
stack_brackets([H|T],S):-
	member(H,[40,91,123]),
	append(S,[H],S1),
	stack_brackets(T,S1).
stack_brackets([H|T],S):-
	member(H,[41,93,125]),
	append(L,[40],S), !,
	append(M,[H],L),
	stack_brackets(T,M).
stack_brackets([H|T],S):-
	member(H,[41,93,125]),
	non_member(H,[40,91,123]),
	!,
	stack_brackets(T,S).
stack_brackets([_|T],S):-
	stack_brackets(T,S).
 
non_member(E,L):-
	member(E,L),
	!,fail.
non_member(_,_).
 
