expr_tree(Tokens, Tree):-
	expr_tree(Tokens, [], Tree).
 
expr_tree([], Tree, Tree):-!.
expr_tree([Token|Tokens], Stack, Tree):-
	(   number(Token)
	->  expr_tree(Tokens, [tree(Token, nil, nil)|Stack], Tree)
	;   expr_tree(Tokens, Stack, Left),
	    expr_tree(Stack, Right),
	    tree(Token, Left, Right, Tree)).
 
tree(Token, Left, Right, tree(Token, Left, Right)):-
	number(Token),
	Left \= nil,
	Right \= nil.
 
render(nil, ""):-!.
render(tree(Token, Left, Right), Rendered):-
	render(Left, LeftRendered),
	render(Right, RightRendered),
	string_concat("(", LeftRendered, LR),
	string_concat(LR, Token, LRT),
	string_concat(LRT, RightRendered, LRTS),
	string_concat(LRTS, ")", Rendered).
 
main:-
	read_line_to_string(user_input, Line),
	atomic_list_concat(Tokens, ' ', Line),
	expr_tree(Tokens, Tree),
	render(Tree, Rendered),
	writeln(Rendered).
