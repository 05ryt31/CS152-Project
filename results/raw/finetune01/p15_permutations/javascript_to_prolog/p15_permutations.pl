permutation(L, P) :-
	length(P, L),
	member(P, permutation(L)).
 
permutation(0, []).
permutation(N, [H|T]) :-
	N > 0,
	N1 is N - 1,
	permutation(N1, T),
	select(H, T, T1).
 
main :-
	L = "abc",
	permutation(L, P),
	maplist(writeln, P).
 
