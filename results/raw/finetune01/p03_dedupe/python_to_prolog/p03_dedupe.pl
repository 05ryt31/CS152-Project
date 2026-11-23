 
:- use_module(library(lambda)).
 
remove_duplicates :-
	L = [1,4,5,6,4,7,8,9,8],
	aggregate(
		all,
		(   member(X,L), \+ member(X,R), aggregate(all, Y^(member(Y,L),Y\=X), R)),
		R),
	writeln(R).
 
