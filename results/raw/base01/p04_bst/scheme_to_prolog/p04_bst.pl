:- use_module(library(lists)).
:- use_module(library(readutil)).

insert(Tree, Value, NewTree) :-
    (   Tree = [],
        NewTree = [Value, [], []]
    ;   Tree = [Root, Left, Right],
        (   Value < Root,
            insert(Left, Value, NewLeft),
            NewTree = [Root, NewLeft, Right]
        ;   Value >= Root,
            insert(Right, Value, NewRight),
            NewTree = [Root, Left, NewRight]
        )
    ).

inorder([], []) :- !.
inorder([Root | Rest], [Root | InorderRest]) :-
    inorder(Rest, InorderRest).

preorder([], []) :- !.
preorder([Root | Rest], [Root | PreorderRest]) :-
    preorder(Rest, PreorderRest).

height([], 0) :- !.
height([_ | Rest], Height) :-
    height(Rest, SubHeight),
    Height is SubHeight + 1.

print_list([]) :- !.
print_list([H | T]) :-
    write(H),
    (   T = []
    ->  nl
    ;   write(' '),
        print_list(T)
    ).

numbers(Line, Values) :-
    (   Line = "",
        Values = []
    ;   split_string(Line, " ", "", Tokens),
        maplist(atom_number, Tokens, Values)
    ).

safe_read_line(Line) :-
    read_line_to_string(current_input, Line),
    (   Line = "",
        true
    ;   true
    ).

build_tree([], Tree) :-
    Tree = [].
build_tree([H | T], Tree) :-
    build_tree(T, NewTree),
    insert(NewTree, H, Tree).

p04_bst :-
    safe_read_line(Line),
    numbers(Line, Values),
    build_tree(Values, Tree),
    inorder(Tree, InorderList),
    preorder(Tree, PreorderList),
    height(Tree, Height),
    print_list(InorderList),
    print_list(PreorderList),
    format('~d~n', [Height]),
    halt.
