nqueens(N, L) :-
	length(L, N),
	maplist(queens, L).
 
queens([X|T]) :-
	queens(T, X, 1).
 
queens([], _X, _N).
queens([Y|T], X, N) :-
	N1 is N+1,
	dif(X, Y),
	X1 is abs(X-Y),
	dif(N1, X1),
	queens(T, X, N1).
 
