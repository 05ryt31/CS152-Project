:- use_module(library(lists)).
:- use_module(library(readutil)).

% Define the Tree data structure
tree(Empty).
tree(node(X, Left, Right)).

% Insert a value into the BST
insert(Empty, X, node(X, Empty, Empty)).
insert(node(Y, Left, Right), X, node(Y, NewLeft, Right)) :-
    X < Y,
    insert(Left, X, NewLeft).
insert(node(Y, Left, Right), X, node(Y, Left, NewRight)) :-
    X >= Y,
    insert(Right, X, NewRight).

% In-order traversal of the BST
inorder(Empty, []).
inorder(node(X, Left, Right), List) :-
    inorder(Left, LeftList),
    inorder(Right, RightList),
    append(LeftList, [X|RightList], List).

% Pre-order traversal of the BST
preorder(Empty, []).
preorder(node(X, Left, Right), [X|List]) :-
    preorder(Left, LeftList),
    preorder(Right, RightList),
    append(LeftList, RightList, List).

% Calculate the height of the BST
height(Empty, 0).
height(node(_, Left, Right), H) :-
    height(Left, LH),
    height(Right, RH),
    H is 1 + max(LH, RH).

% Convert list of integers to string
show_line(List) :-
    maplist(writeln, List),
    nl.

% Safe get line function
safe_get_line(Stream, Line) :-
    at_end_of_stream(Stream), !,
    Line = "".
safe_get_line(Stream, Line) :-
    read_line(Stream, Line).

% Main predicate
p04_bst :-
    current_input(Input),
    safe_get_line(Input, Line),
    split_string(Line, " ", "", Values),
    maplist(atom_number, Values, Numbers),
    foldl(insert, Numbers, Empty, Tree),
    inorder(Tree, InorderList),
    preorder(Tree, PreorderList),
    height(Tree, Height),
    format("~w~n", [InorderList]),
    format("~w~n", [PreorderList]),
    format("~d~n", [Height]),
    halt.
