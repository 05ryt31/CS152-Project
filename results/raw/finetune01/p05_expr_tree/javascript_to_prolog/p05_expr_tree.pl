:- use_module(library(lambda)).
 
% parse expression into tree
parse_expr(In, Tree):-
	string_chars(In, InList),
	atom_chars(' ', Space),
	exclude(\X^(X == Space), InList, InListNoSpace),
	atomic_list_concat(InListNoSpace, Tokens),
	reverse(Tokens, TokensRev),
	build_tree(TokensRev, Tree).
 
build_tree([Token], Token):-!.
build_tree([Token|TokensRest], Tree):-
	member(Token, ['+', '*', '-']),
	member(Index, [1,2]),
	nth0(Index, TokensRest, Right),
	Index1 is Index + 1,
	sublist(TokensRest, Index1, Index, Left),
	build_tree(Left, LeftTree),
	build_tree(Right, RightTree),
	Tree =.. [Token, LeftTree, RightTree].
 
sublist(List, Start, Length, Sublist):-
	Start >= 0,
	Length > 0,
	Start < Length,
	End is Start + Length - 1,
	length(Sublist, Length),
	succ(BeforeStart, Start),
	succ(AfterEnd, End),
	append(_Before, BeforeSublist, List),
	append(BeforeSublist, _After),
	append(_Before, [_First|_Middle], BeforeSublist),
	append(_Middle, [_Last|_After], AfterEnd),
	append(_Before, [_First|Sublist], List),
	append(Sublist, [_Last|_After], List).
 
% print tree in infix notation
print_expr(Tree):-
	print_expr(Tree, 0, MaxDepth),
	writef('(%w)\n', [MaxDepth]).
 
print_expr(Token, Depth, MaxDepth):-
	var(Token),
	MaxDepth is Depth,
	writef('%w\n', [Token]).
 
print_expr(Tree, Depth, MaxDepth):-
	is_node(Tree),
	Tree =.. [Op, Left, Right],
	Depth1 is Depth + 1,
	print_expr(Left, Depth1, MaxDepth1),
	print_expr(Right, Depth1, MaxDepth2),
	MaxDepth is max(MaxDepth1, MaxDepth2),
	writef('%w ', [Op]).
 
is_node(Node):-
	Node \= [],
	\+ atomic(Node).
 
