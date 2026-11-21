:- use_module(library(lists)).
:- use_module(library(readutil)).

node(Value, Left, Right).

insert(nil, Value, node(Value, nil, nil)).
insert(node(Value, Left, Right), InsertValue, Result) :-
    InsertValue < Value,
    insert(Left, InsertValue, NewLeft),
    Result = node(Value, NewLeft, Right).
insert(node(Value, Left, Right), InsertValue, Result) :-
    InsertValue >= Value,
    insert(Right, InsertValue, NewRight),
    Result = node(Value, Left, NewRight).

inorder(nil, []).
inorder(node(_, Left, Right), Values) :-
    inorder(Left, LeftValues),
    append(LeftValues, [Value], Temp),
    inorder(Right, RightValues),
    append(Temp, RightValues, Values).

preorder(nil, []).
preorder(node(Value, Left, Right), Values) :-
    append([Value], LeftValues, Temp),
    preorder(Left, LeftValues),
    append(Temp, RightValues, Temp2),
    preorder(Right, RightValues),
    append(Temp2, Values, Values).

height(nil, 0).
height(node(_, Left, Right), Height) :-
    height(Left, LeftHeight),
    height(Right, RightHeight),
    Height is 1 + max(LeftHeight, RightHeight).

p04_bst :-
    read_line_to_string(current_input, Input),
    split_string(Input, Tokens, ' '),
    maplist(string_to_integer, Tokens, Integers),
    foldl(insert, Integers, nil, Root),
    inorder(Root, InOrderValues),
    preorder(Root, PreOrderValues),
    format("~w~n", [InOrderValues]),
    format("~w~n", [PreOrderValues]),
    height(Root, Height),
    format("~d~n", [Height]),
    halt.
