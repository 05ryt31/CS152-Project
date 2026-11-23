:- use_module(library(lambda)).
 
% parse expression into list of tokens
parse_expr(String, Tokens) :-
	string_chars(String, Chars),
	atom_chars(Atom, Chars),
	atomic_list_concat(Tokens, Atom).
 
% build expression tree from list of tokens
build_expr_tree([Token], Token) :- atomic(Token), !.
build_expr_tree(Tokens, Tree) :-
	split_token_list(Tokens, Left, Operator, Right),
	build_expr_tree(Left, LeftTree),
	build_expr_tree(Right, RightTree),
	Tree =.. [Operator, LeftTree, RightTree].
 
% split token list into left, operator, and right lists
split_token_list([Op, L, R], L, Op, R) :- member(Op, ['+', '-', '*', '/']), atom(L), atom(R).
 
% print expression tree in infix notation
print_expr_tree(Tree) :-
	print_expr_tree(Tree, 0).
 
print_expr_tree(Tree, N) :-
	(   atomic(Tree) ->
		format('~w~n', [Tree])
	;
		length(Tree, 3),
		append(_,[Op, Left, Right], Tree),
		N1 is N + 1,
		print_tree(N1, N),
		write(Op),
		print_tree(N, N1),
		print_expr_tree(Left, N1),
		print_expr_tree(Right, N1)
	).
 
print_tree(N, M) :-
	between(M, N, _),
	write(' ').
 
main :-
	parse_expr('a+b*c-d/e', Tokens),
	build_expr_tree(Tokens, Tree),
	print_expr_tree(Tree).
 
