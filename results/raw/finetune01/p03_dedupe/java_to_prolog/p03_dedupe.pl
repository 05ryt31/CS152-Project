 
:- use_module(library(lambda)).
 
remove_duplicates :-
	L = [1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9],
	aggregate(
		all,
		(   member(V,L), V \= _V1),
		VL),
	writeln(VL).
 
