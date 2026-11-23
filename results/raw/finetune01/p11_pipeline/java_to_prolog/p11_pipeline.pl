pipeline :-
	L = [1, 3, 5, 7, 9],
	% map add 2
	maplist(add(2), L, L1),
	writef('Map add 2: '), writeln(L1),
 
	% filter even
	include(even, L1, L2),
	writef('Filter even: '), writeln(L2),
 
	% map mul 3
	maplist(mul(3), L2, L3),
	writef('Map mul 3: '), writeln(L3),
 
	% filter gt 10
	include(gt(10), L3, L4),
	writef('Filter gt 10: '), writeln(L4).
 
add(X, Y, Z) :- Z is X + Y.
mul(X, Y, Z) :- Z is X * Y.
even(X) :- 0 is X mod 2.
gt(V, V1) :- V1 > V.
