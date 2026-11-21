:- use_module(library(lists)).
:- use_module(library(readutil)).

:- initialization(p04_bst).

p04_bst :-
    read_line_to_string(current_input, Line),
    trim(Line, Trimmed),
    split_string(Trimmed, ' ', '', Values),
    maplist(string_to_number, Values, Numbers),
    build_tree(Numbers, Root),
    inorder_traversal(Root, InOrder),
    preorder_traversal(Root, PreOrder),
    format('~w~n', [InOrder]),
    format('~w~n', [PreOrder]),
    format('~d~n', [height(Root)]),
    halt.

string_to_number(S, N) :-
    number_string(N, S).

build_tree([], _).
build_tree([H|T], Tree) :-
    insert(H, T, Tree).

insert(X, [], X).
insert(X, [Y|T], Tree) :-
    (   X < Y -> Tree =.. ['.', X, Left, Right],
        insert(X, T, Left),
        Tree =.. ['.', X, Left, Right]
    ;   otherwise -> Tree =.. ['.', Y, Left, Right],
        insert(X, T, Right),
        Tree =.. ['.', Y, Left, Right]
    ).

inorder_traversal([], []).
inorder_traversal([Node|T], InOrder) :-
    inorder_traversal(Node, Left),
    append(Left, [Node], Temp),
    inorder_traversal(T, Right),
    append(Temp, Right, InOrder).

preorder_traversal([], []).
preorder_traversal([Node|T], PreOrder) :-
    append([Node], Left, Temp),
    preorder_traversal(Node, Left),
    preorder_traversal(T, Right),
    append(Temp, Right, PreOrder).

height([]) :- !, 0.
height([_]) :- !, 1.
height([_, L, R]) :-
    height(L, HL),
    height(R, HR),
    max(HL, HR, H),
    H1 is H + 1,
    H1.
