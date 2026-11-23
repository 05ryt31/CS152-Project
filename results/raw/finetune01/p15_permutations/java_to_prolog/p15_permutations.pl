permutation(L, L1) :-
	length(L, Len),
	length(L1, Len),
	permutation(L, L1).
 
permutation([], []).
permutation([X|T], L) :-
	select(X, T, TL),
	permutation(TL, L).
 
select(X, [X|T], T).
select(X, [Y|T], [Y|R]) :-
	select(X, T, R).
 
main :-
	L = "abc",
	permutation(L, L1),
	maplist(my_writef, L1),
	nl,
	permutation("aabb", L2),
	length(L2, N),
	format('Number of permutations ~w~n', [N]).
 
my_writef(W) :-
	writef('%w ', W).
 
