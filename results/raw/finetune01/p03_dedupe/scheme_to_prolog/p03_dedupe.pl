 
:- use_module(library(lambda)).
 
remove_duplicates :-
	L = [a,b,c,a,d,e,b,f,g,c],
	aggregate(
		all,
		(   member(V,L), \+ member(V,R), aggregate(all,V,R,_)),
		VL),
	format('Original list ~w~n', [L]),
	maplist(\X^(format('~w ', X)), L),
	format('Deduplicated list ~w~n', [VL]),
	maplist(\X^(format('~w ', X)), VL).
 
