:- use_module(library(lists)).
:- use_module(library(readutil)).

% Define the Tree data structure
tree(leaf(X), X).
tree(op(Op, Left, Right), Op, Left, Right).

% Build the tree from a list of tokens
build_tree(Line) :-
    string_tokens(Line, Tokens),
    build_tree(Tokens, []).

build_tree([], Acc) :-
    reverse(Acc, Trees),
    member(Tree, Trees),
    !,
    tree(Tree, Result),
    format('~w~n', [Result]).
build_tree([Token | Rest], Acc) :-
    Token =:= '+' ; Token =:= '-' ; Token =:= '*' ->
        pop_n(Rest, 2, [Right, Left | Rest2]),
        NewAcc = [op(Token, Left, Right) | Acc],
        build_tree(Rest2, NewAcc);
    NewAcc = [leaf(Token) | Acc],
    build_tree(Rest, NewAcc).

pop_n(_, 0, List) :-
    !,
    List = [].
pop_n([H | T], N, [H | NT]) :-
    M is N - 1,
    pop_n(T, M, NT).

% Entry point of the program
p05_expr_tree :-
    read_line_to_string(current_input, Line),
    build_tree(Line),
    halt.
