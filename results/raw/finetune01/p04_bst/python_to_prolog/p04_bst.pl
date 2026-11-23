 
:- use_module(library(clpfd)).
 
% A binary tree is either empty or a node whose left and right children are trees.
tree(empty).
tree(node(Value, Left, Right)) :- 
	integer(Value),
	tree(Left),
	tree(Right).
 
% Insert a value into a tree.
insert(Value, Tree, Tree) :-
	Tree == empty,
	Value #>= Value #<=> 1.
insert(Value, Tree, Tree) :-
	Tree = node(_, _, _),
	Value #=< Value #<=> 1.
insert(Value, Tree, Tree) :-
	Tree = node(_, _, _),
	Value #> Value #<=> 1.
insert(Value, Tree, NewTree) :-
	Tree = node(V, L, R),
	(   Value #= V #<=> 1 -> NewTree = Tree;
	    Value #< V #<=> 1 -> insert(Value, L, NewL), NewTree = node(V, NewL, R);
	    Value #> V #<=> 1 -> insert(Value, R, NewR), NewTree = node(V, L, NewR)).
 
% In-order traversal of a tree.
inorder(empty, []).
inorder(node(Value, Left, Right), InOrder) :-
	inorder(Left, InOrderLeft),
	append(InOrderLeft, [Value], InOrderMiddle),
	inorder(Right, InOrderRight),
	append(InOrderMiddle, InOrderRight, InOrder).
 
% Pre-order traversal of a tree.
preorder(empty, []).
preorder(node(Value, Left, Right), PreOrder) :-
	preorder(Left, PreOrderLeft),
	preorder(Right, PreOrderRight),
	append([Value|PreOrderLeft], PreOrderRight, PreOrder).
 
% Height of a tree.
height(empty, 0).
height(node(_, Left, Right), H) :-
	height(Left, HL),
	height(Right, HR),
	H #= max(HL, HR) + 1.
 
