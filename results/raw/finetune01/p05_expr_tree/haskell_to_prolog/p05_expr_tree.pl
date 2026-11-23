 
:- use_module(library(lambda)).
 
% parse tree node
tree(node(Term, Left, Right), Term, Left, Right).
 
% parse tree leaf
tree(leaf(Term), Term, nil, nil).
 
% parse tree root
tree(root(Tree), _, Left, Right) :-
	tree(Tree, _, Left, Right).
 
% parse tree leaf
tree(leaf(Term), Term, nil, nil).
 
% parse tree node
tree(node(Term, Left, Right), Term, Left, Right).
 
% parse tree root
tree(root(Tree), _, Left, Right) :-
	tree(Tree, _, Left, Right).
 
% build expression tree
build_expression_tree(Line, Tree) :-
	atom_chars(Line, Chars),
	build_expression_tree(Chars, [], Tree).
 
build_expression_tree([], Stack, Tree) :-
	length(Stack, 3),
	pop_stack(Stack, Term, Rest),
	tree(Tree, Term, Left, Right),
	build_expression_tree(Rest, [node(Term, Left, Right)|Stack]).
 
build_expression_tree([Term|Rest], Stack, Tree) :-
	member(Term, ['+', '-', '*', '/']),
	stack_length(Stack, Len),
	Len < 2,
	build_expression_tree(Rest, [Term|Stack], Tree).
 
build_expression_tree([Term|Rest], Stack, Tree) :-
	member(Term, ['+', '-', '*', '/']),
	stack_length(Stack, Len),
	Len >= 2,
	pop_stack(Stack, Right, Rest),
	pop_stack(Rest, Left, NewStack),
	build_expression_tree(Rest, [node(Term, Left, Right)|NewStack], Tree).
 
build_expression_tree([Term|Rest], Stack, Tree) :-
	\+ member(Term, ['+', '-', '*', '/']),
	stack_length(Stack, Len),
	Len > 0,
	pop_stack(Stack, Right, Rest),
	build_expression_tree(Rest, [node(Term, leaf(Term), Right)|Rest], Tree).
 
build_expression_tree([Term|Rest], Stack, Tree) :-
	\+ member(Term, ['+', '-', '*', '/']),
	stack_length(Stack, Len),
	Len =< 0,
	build_expression_tree(Rest, [leaf(Term)|Stack], Tree).
 
% evaluate expression tree
evaluate_expression_tree(Tree, Value) :-
	evaluate_expression_tree(Tree, 0, Value).
 
evaluate_expression_tree(leaf(Value), _, Value).
 
evaluate_expression_tree(node('+', Left, Right), Acc, Value) :-
	evaluate_expression_tree(Left, Acc, LValue),
	evaluate_expression_tree(Right, LValue, RValue),
	Value is LValue + RValue.
 
evaluate_expression_tree(node('-', Left, Right), Acc, Value) :-
	evaluate_expression_tree(Left, Acc, LValue),
	evaluate_expression_tree(Right, LValue, RValue),
	Value is LValue - RValue.
 
evaluate_expression_tree(node('*', Left, Right), Acc, Value) :-
	evaluate_expression_tree(Left, Acc, LValue),
	evaluate_expression_tree(Right, LValue, RValue),
	Value is LValue * RValue.
 
evaluate_expression_tree(node('/', Left, Right), Acc, Value) :-
	evaluate_expression_tree(Left, Acc, LValue),
	evaluate_expression_tree(Right, LValue, RValue),
	Value is LValue / RValue.
 
% print expression tree
print_expression_tree(Tree) :-
	print_expression_tree(Tree, 0).
 
print_expression_tree(leaf(Value), _Acc) :-
	writef('%w\n', [Value]).
 
print_expression_tree(node(Term, Left, Right), Acc) :-
	Acc1 is Acc + 4,
	print_expression_tree(Right, Acc1),
	writef(' %w\n', [Term]),
	print_expression_tree(Left, Acc1).
 
% main
main :-
	read_line_to_string(user_input, Line),
	build_expression_tree(Line, Tree),
	evaluate_expression_tree(Tree, Value),
	print_expression_tree(Tree),
	writeln(Value).
 
