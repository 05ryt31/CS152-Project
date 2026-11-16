:- use_module(library(read_util)).
:- use_module(library(lists)).

p05_expr_tree :-
    read_line_to_string(current_input, Input),
    split_string(Input, Tokens, ' '),
    parse_tokens(Tokens, Stack),
    LastNode = Stack,
    format('~w~n', [render(LastNode)]),
    halt(0).

parse_tokens([], []).
parse_tokens([Token | Rest], Stack) :-
    (   Token = '+' ; Token = '-' ; Token = '*' ),
    pop(Stack, Right),
    pop(Stack, Left),
    NewNode =.. [Token, Left, Right],
    push(NewNode, Stack, NewStack),
    parse_tokens(Rest, NewStack).
parse_tokens([Token | Rest], [Node | Stack]) :-
    Node =.. [Token],
    parse_tokens(Rest, [Node | Stack]).

pop([H | T], H, T).

push(X, Stack, [X | Stack]).

render(Node) :-
    Node =.. [Token, Left, Right],
    render(Left, LeftStr),
    render(Right, RightStr),
    format('~w ~w ~w', [LeftStr, Token, RightStr]).
render(Token, Token) :-
    atom(Token).
