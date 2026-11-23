 
:- use_module(library(clpfd)).
 
% Run-length encoding of a list (Run-Length Encoding)
rl_encode([], []).
rl_encode([X], [[1,X]]) :- !.
rl_encode(L, RLE) :-
	run_length_encoding(L, RLE).
 
% Run-length encoding of a list
run_length_encoding([], []):-!.
run_length_encoding([X], [[1,X]]):-!.
run_length_encoding([X|T], RLE):-
	run_length(X, T, X, N, R, T1),
	N #> 0,
	R = [N-X],
	!,
	run_length_encoding(T1, RLE).
 
% Count elements in a list
run_length(_, [], V, V, _, _):-!.
run_length(V, [V|L], V1, V2, R, L1):-
	V #= V1,
	V2 #= V1 + 1,
	!,
	run_length(V, L, V, V2, R, L1).
run_length(V, [_|L], V1, V2, R, L1):-
	run_length(V, L, V1, V2, R, L1).
 
