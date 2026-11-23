nqueens(N):-
	length(L,N),
	nqueens(L).
 
nqueens([]).
nqueens([H|T]):-
	safe(H,T),
	nqueens(T).
 
safe([],_).
safe([H|T],L):-
	\+ member(H,L),
	H1 is H+1,
	H2 is H-1,
	maplist(\X^(X \= H1, X \= H2), L),
	safe(T,L).
 
