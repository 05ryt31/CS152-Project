permutation(L, P) :-
	length(P, L),
	member(_,P), permutation(L,P).
 
permutation(0,[]):-!.
permutation(N,[H|T]):- N>0, M is N-1, select(H,L,M), permutation(M,T).
 
select(E,[E|L],L):-!.
select(E,[X|L],[X|R]):- select(E,L,R).
 
main :- 
	L = "abc", 
	permutation(L, P), 
	maplist(writeln, P).
