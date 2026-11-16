:- use_module(library(readutil)).
:- use_module(library(lists)).

p05_expr_tree :-
    read_line_to_string(current_input, Input),
    Tokens =.. [tokens, Input],
    parse_tokens(Tokens, Stack),
    render(Stack, Result),
    format('~w~n', [Result]),
    halt.

parse_tokens([], []).
parse_tokens([Token | Rest], Stack) :-
    member_of('+-*', Token), !,
    pop(Stack, Right),
    pop(Stack, Left),
    NewNode =.. [token, Token, Left, Right],
    parse_tokens(Rest, [NewNode | Stack]).
parse_tokens([Token | Rest], [NewNode | Stack]) :-
    NewNode =.. [token, Token],
    parse_tokens(Rest, [NewNode | Stack]).

pop([H | T], H, T).

member_of(X, [X | _]).
member_of(X, [_ | T]) :- member_of(X, T).

render([], '').
render([token(Token, Left, Right)], Result) :-
    render(Left, LeftStr),
    render(Right, RightStr),
    Result =.. ['(', LeftStr, Token, RightStr, ')'].
render([token(Token, Left, Right) | Rest], Result) :-
    render(Left, LeftStr),
    render(Right, RightStr),
    render(Rest, RestStr),
    Result =.. ['(', LeftStr, Token, RightStr, ' ', RestStr, ')'].
