 
:- use_module(library(lambda)).
 
% rle("aaabbbcccc", L).
rle(S, L) :-
	string_chars(S, SL),
	run_length_encode(SL, L).
 
% run_length_encode([a,a,a,b,b,c,c,c], L).
run_length_encode([], []).
run_length_encode(L, R) :-
	run_length_encode(L, [], R).
 
% run_length_encode([a,a,a,b,b,c,c,c], [], L).
run_length_encode([], RL, RL) :-
	run_length(RL).
 
% run_length_encode([a,a,a,b,b,c,c,c], [a,3], L).
run_length_encode([H|T], RL, R) :-
	(   run_length(RL)
	->  last_pair(VL, N, RL),
	    V \= H,
	    !,
	    N1 is N + 1,
	    RL1 = [(V,N1)],
	    run_length_encode(T, RL1, R)
	;   V = H,
	    N = 1,
	    !,
	    RL1 = [(V,N)],
	    run_length_encode(T, RL1, R)
	).
 
% run_length_encode([a,a,a,b,b,c,c,c], [a,3,[b,2],[c,3]], L).
run_length_encode([_], RL, RL).
run_length_encode([H|T], RL, R) :-
	last_pair(VL, N, RL),
	V \= H,
	!,
	N1 is N + 1,
	RL1 = [(VL,N1)],
	run_length_encode([H|T], RL1, R).
 
% run_length_encode([a,a,a,b,b,c,c,c], [a,3,[b,2],[c,3]], L).
run_length_encode([H|T], RL, R) :-
	last_pair(VL, N, RL),
	V = H,
	!,
	N1 is N + 1,
	RL1 = [(VL,N1)],
	run_length_encode(T, RL1, R).
 
last_pair(X, X, [X]).
last_pair(Y, X, [Z|T]) :-
	last_pair(Y, X, T).
 
run_length([]).
run_length([(V,N)|T]) :-
	N > 0,
	run_length(T).
 
