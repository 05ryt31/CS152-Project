:- use_module(library(lists)).
:- use_module(library(readutil)).

p05_expr_tree :-
    read_line_to_string(current_input, Line),
    Tokens =:= string_split(Line),
    Tree =:= build(Tokens),
    format('~s~n', [render(Tree)]),
    halt(0).

build([]) --> [].
build([Token | Rest]) -->
    { member(Token, ['+', '-', '*']) },
    pop(Rest, Right),
    pop(Rest, Left),
    [list(Token, Left, Right)],
    build(Rest).
build([Token | Rest]) -->
    [Token],
    build(Rest).

pop([H | T], H) --> !, [T].

render(Tree) :-
    string_is_list(Tree), !,
    render_string(Tree).
render(Tree) :-
    atom(Tree), !,
    atom_codes(Tree, Codes),
    render_string(Codes).
render(Tree) :-
    render_string('('),
    render(Tree[1]),
    render_string(' '),
    render(Tree[0]),
    render_string(' '),
    render(Tree[2]),
    render_string(')').

render_string(String) :-
    format('~s', [String]).
