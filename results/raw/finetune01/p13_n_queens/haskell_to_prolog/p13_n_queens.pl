nqueens(N, L) :-
	length(L, N),
	maplist(safe, L).
 
safe(I) :-
	I #> 0,
	I #< N,
	\+ (J in 1..N, J #\= I, X #= I-J, Y #= I+J, X #=< N, Y #=< N, X #>= 1, Y #>= 1, X #= V1 * A, Y #= V2 * B, V1 #= V2, A #= B, V1 #* V2 #= X * Y).
 
solve :-
	N = 8,
	nqueens(N, L),
	maplist(my_write, L).
 
my_write(V) :-
	V #> 0,
	V #< N,
	writef('%w ', [V]).
 
