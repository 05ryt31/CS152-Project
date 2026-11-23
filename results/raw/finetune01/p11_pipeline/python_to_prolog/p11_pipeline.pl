pipeline :-
	L = [1,2,3,4,5],
	pipe(L, [[map, add, 1], [filter, even]], R),
	writeln(R).
 
pipe([], _, []):-!.
pipe([H|T], L, R):-
	run_pipe(H, L, V),
	pipe(T, L, VR),
	R = [V | VR].
 
run_pipe(V, [], V):-!.
run_pipe(V, [[M, N, P]|T], R):-
	call(M, V, N, P, V1),
	run_pipe(V1, T, R).
 
% map
map(add, V, A, R):- R is V+A.
map(mul, V, A, R):- R is V*A.
 
% filter
filter(even, V, _, R):- V mod 2 =:= 0, !, R = V.
filter(even, _, _, R):- R = none.
filter(odd, V, _, R):- V mod 2 =\= 0, !, R = V.
filter(odd, _, _, R):- R = none.
filter(gt, V, A, R):- V > A, !, R = V.
filter(gt, _, _, R):- R = none.
 
