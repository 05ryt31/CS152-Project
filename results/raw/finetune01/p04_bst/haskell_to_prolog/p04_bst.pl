 
:- use_module(library(clpfd)).
 
% A binary search tree is either empty or consists of a node with two subtrees.
bst(empty).
bst(node(_, L, R)) :- bst(L), bst(R).
 
% Inserting an element in a BST.
insert(X, empty, node(X, empty, empty)).
insert(X, T, node(Y, L, R)) :-
	X #< Y,
	!,
	insert(X, L, N_L),
	bst(node(Y, N_L, R)).
insert(X, T, node(Y, L, R)) :-
	X #>= Y,
	!,
	insert(X, R, N_R),
	bst(node(Y, L, N_R)).
 
% In-order traversal of a BST.
in_order(empty, []).
in_order(node(X, L, R), O) :-
	in_order(L, OL),
	in_order(R, OR),
	append(OL, [X|OR], O).
 
% Pre-order traversal of a BST.
pre_order(empty, []).
pre_order(node(X, L, R), [X|P]) :-
	pre_order(L, PL),
	pre_order(R, PR),
	append(PL, PR, P).
 
% Height of a BST.
height(empty, 0).
height(node(_, L, R), H) :-
	height(L, HL),
	height(R, HR),
	H #= max(HL, HR) + 1.
 
% Example usage.
example :-
	L = [5, 3, 7, 8, 6, 9],
	foldl(insert, L, empty, T),
	in_order(T, I),
	write('In order: '), writeln(I),
	pre_order(T, P),
	write('Pre order: '), writeln(P),
	height(T, H),
	write('Height: '), writeln(H).
 
