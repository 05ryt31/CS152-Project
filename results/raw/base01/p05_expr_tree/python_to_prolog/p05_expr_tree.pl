:- use_module(library(readutil)).

node(Token, Left, Right) :-
    atom(Token),
    (   Left = null,
        Right = null
    ;   Left \= null,
        Right \= null
    ).

build(Tokens, Tree) :-
    build_stack(Tokens, [], Stack),
    [Tree] = Stack.

build_stack([], Stack, Stack).
build_stack([Token | Tokens], Stack, NewStack) :-
    (   Token = '+' ; Token = '-' ; Token = '*'
    ->  pop(Stack, Right),
        pop(Stack, Left),
        NewStack = [node(Token, Left, Right) | Stack]
    ;   NewStack = [node(Token, null, null) | Stack]
    ).

pop([H | T], H, T).

render(Tree, Result) :-
    (   Tree = node(Token, null, null)
    ->  Result = Token
    ;   Result = '('
        , render(Tree.left, Left),
        format(atom(Left), '~w', [Left]),
        format(atom(Middle), ' ~w ', [Token]),
        render(Tree.right, Right),
        format(atom(Right), '~w', [Right]),
        Result = '('
        , format(atom(Result), '~w~w~w', [Left, Middle, Right])
        , Result = ')'
    ).

p05_expr_tree :-
    read_line_to_string(current_input, Input),
    split_string(Input, ' ', '', Tokens),
    build(Tokens, Tree),
    render(Tree, Result),
    format('~w~n', [Result]),
    halt.
