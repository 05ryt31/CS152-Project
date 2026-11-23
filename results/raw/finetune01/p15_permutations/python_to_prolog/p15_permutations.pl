permutation(L, P) :-
	length(P, L),
	member(_,P),
	maplist(dif(_,_),P).
 
permute(L, PL) :-
	permutation(L, PL).
 
