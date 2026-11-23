```prolog
:- use_module(library(clpfd)).
 
% A binary tree is either empty or a node with two subtrees.
tree(empty).
tree(node(_, L, R)) :- tree(L), tree(R).
 
% An expression tree is a tree where all leaves are numbers and all nodes are operators.
expr_tree(T) :-
	(   T == empty -> true ; 
	    T = node(Op, L, R),
	    Op \= empty,
	    number(Op),
	    expr_tree(L),
	    expr_tree(R)).
 
% Build an expression tree from a list of tokens.
build_expr_tree([], empty).
build_expr_tree([Op], Op) :- number(Op).
build_expr_tree([Op|Tokens], Tree) :-
	number(Op),
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	\+number(Op),
	build_expr_tree(Tokens, Left, Right),
	Left = node(Op, _, _),
	Right = node(Op, _, _),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree(Tokens, Tree) :-
	length(Tokens, N),
	N #> 1,
	Tokens = [Op|_],
	\+number(Op),
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree(Tokens, Tree) :-
	length(Tokens, N),
	N #< 3,
	!,
	writef('Error: %w\n', [Tokens]),
	fail.
build_expr_tree(Tokens, Tree) :-
	length(Tokens, N),
	N #> 3,
	!,
	writef('Error: %w\n', [Tokens]),
	fail.
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(Tokens, Left, Right),
	Tree = node(Op, Left, Right).
build_expr_tree([Op|Tokens], Tree) :-
	build_expr_tree(T
