:- initialization(p05_expr_tree, main).

p05_expr_tree :- 
    read_line_to_string(user_input, Line),
    split_string(Line, " ", " ", Tokens), 
    build(Tokens, [], [Tree]), 
    render(Tree, Text), 
    writeln(Text),
    halt.

build([], Stack, Stack).
build([Token|Tokens], [Right, Left|Rest], Result) :- 
    memberchk(Token, ["+", "-", "*"]), !, 
    build(Tokens, [op(Token, Left, Right)|Rest], Result).
build([Token|Tokens], Stack, Result) :- build(Tokens, [leaf(Token)|Stack], Result).

render(leaf(Text), Text).
render(op(Op, Left, Right), Text) :- 
    render(Left, L), 
    render(Right, R), 
    string_concat("(", L, A), 
    string_concat(A, " ", B), 
    string_concat(B, Op, C), 
    string_concat(C, " ", D),
    string_concat(D, R, E), 
    string_concat(E, ")", Text).
