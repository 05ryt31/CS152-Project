:- use_module(library(clpfd)).
 
% Problem 13: N Queens
n_queens(N, Solution):-
	length(Solution, N),
	Solution = [H|_],
	H ins 1..N,
	fd_all_different(Solution),
	maplist(attack, Solution, Solution).
 
attack(X, Y):- abs(X-Y) #\= 0.
 
