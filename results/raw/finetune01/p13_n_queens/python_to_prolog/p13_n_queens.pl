nqueens(N) :-
	length(L,N),
	nq(L,0,L1),
	maplist(show, L1).
 
show([X|_]) :- X > 9, !, format(' ~w ', [X]).
show([X|_]) :- format('~w ', [X]).
show(_).
 
nq([], _, []):-!.
nq([H1|T1], I, R) :-
	I < H1,
	!,
	I1 is I+1,
	nq(T1, I1, R).
nq([_|T1], I, [H2|R]):-
	H2 is I+1,
	I1 is I+1,
	nq(T1, I1, R).
 
