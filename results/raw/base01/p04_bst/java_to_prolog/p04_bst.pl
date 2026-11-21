:- use_module(library(lists)).
:- use_module(library(readutil)).

% Define the Node structure
node(value(_, Left, Right)).

% Insert a value into the BST
insert(null, Value, node(Value, null, null)).
insert(node(Value, Left, Right), NewValue, node(Value, L, R)) :-
    (   NewValue < Value -> insert(Left, NewValue, L), Right = Right
    ;   NewValue >= Value -> Left = Left, insert(Right, NewValue, R)
    ).

% Inorder traversal of the BST
inorder(null, []).
inorder(node(_, Left, Right), List) :-
    inorder(Left, LeftList),
    inorder(Right, RightList),
    append(LeftList, [Value | RightList], List).

% Preorder traversal of the BST
preorder(null, []).
preorder(node(Value, Left, Right), [Value | List]) :-
    preorder(Left, LeftList),
    preorder(Right, RightList),
    append(LeftList, RightList, List).

% Calculate the height of the BST
height(null, 0).
height(node(_, Left, Right), H) :-
    height(Left, LH),
    height(Right, RH),
    H is 1 + max(LH, RH).

% Main predicate
p04_bst :-
    read_line_to_string(current_input, Line),
    (   Line = "" -> Tokens = []
    ;   split_string(Line, " ", "", Tokens)
    ),
    maplist(string_to_integer, Tokens, Values),
    foldl(insert, Values, null, Root),
    inorder(Root, InOrderList),
    preorder(Root, PreOrderList),
    format('~w~n', [InOrderList]),
    format('~w~n', [PreOrderList]),
    height(Root, Height),
    format('~d~n', [Height]),
    halt(0).
