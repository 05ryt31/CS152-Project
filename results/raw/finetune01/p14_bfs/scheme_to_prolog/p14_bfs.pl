:- use_module(library(clpfd)).
 
% read in the data
read_data(N,M,Edges,S,T):-
	read_integers(N),
	read_integers(M),
	read_edges(Edges),
	read_integer(S),
	read_integer(T).
 
% read N integers
read_integers(N):-
	get_number(N),
	N #> 0,
	!.
 
% read M integers
read_integers(M):-
	get_number(M),
	M #> 0,
	!.
 
% read edges
read_edges([H|T]):-
	get_number(V1),
	V1 #> 0,
	get_number(V2),
	V2 #> 0,
	H = [V1,V2],
	read_edges(T).
read_edges([]).
 
% read S integer
read_integer(S):-
	get_number(S),
	S #> 0,
	!.
 
% read T integer
read_integer(T):-
	get_number(T),
	T #> 0,
	!.
 
% get number from stdin
get_number(X):-
	get_char(C),
	(   char_type(C,digit), !,
	X #= C - 48,
	get_number(Y),
	Y #< 10,
	X #= X * 10 + Y
	;
	X #= 0
	).
 
% print out the answer
print_answer(A):-
	A #> 0,
	format('Shortest path length ~w~n',A).
print_answer(_):- format('No solution~n').
 
% solve the problem
solve_problem(N,M,Edges,S,T,A):-
	length(L,N),
	L ins 1..N,
	all_different(L),
 
	% create adjacency list
	create_adjacency_list(Edges,L,AdjList),
 
	% do bfs
	bfs(AdjList,S,T,D),
 
	% check if we found a solution
	(D #> 0 #/\ D #=< N #/\ D #=< M) #==> A #= D,
	(D #> N #\/ D #> M) #==> A #= -1.
 
% create adjacency list
create_adjacency_list([],_,[]):-!.
create_adjacency_list([[X,Y]|T],L,AdjList):-
	index_of(X,L,I),
	index_of(Y,L,J),
	I #\= J,
	(   nth0(I,AdjList,[J|_]), ! ;
	nth0(I,AdjList,[J])),
	create_adjacency_list(T,L,AdjList).
 
% breadth first search
bfs(AdjList,S,T,D):-
	length(AdjList,N),
	length(Q,N),
	Q = [S|Q1],
	length(V,N),
	V = [1|V1],
	bfs(AdjList,Q1,V1,S,T,D).
 
bfs(_,[],_,_,_,D):- D #= 0, !.
bfs(AdjList,[H|T],V,S,T,D):-
	member(H,AdjList),
	(   V[H] #> 0 #/\ V[H] #=< V[S]) #==> !,
	bfs(AdjList,T,V,S,T,D).
bfs(AdjList,[H|T],V,S,T,D):-
	V[H] #= 0,
	V1 = V,
	V1[H] #= V[S] + 1,
	(   member(H,AdjList), ! ;
	AdjList = []),
	bfs(AdjList,T,V1,S,T,D1),
	D #= V[S] + 1 + D1.
 
% main predicate
main:-
	read_data(N,M,Edges,S,T),
	solve_problem(N,M,Edges,S,T,A),
	print_answer(A).
 
