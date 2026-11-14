:- initialization(p04_bst, main).

p04_bst :- 
    read_line_to_string(user_input, Line), 
    nums(Line, Ns),
    foldl(insert, Ns, empty, Tree), 
    inorder(Tree, In), 
    preorder(Tree, Pre), 
    print_nums(In), 
    print_nums(Pre), 
    height(Tree, H), 
    writeln(H),
    halt.

nums(end_of_file, []) :- !.
nums("", []) :- !.
nums(Line, []) :- split_string(Line, " ", " ", []).
nums(Line, Ns) :- 
    split_string(Line, " ", " ", Parts), 
    Parts \= [], 
    maplist(number_string, Ns, Parts).

insert(X, empty, node(X, empty, empty)).
insert(X, node(Y, L, R), node(Y, New, R)) :- 
    X < Y, 
    insert(X, L, New).
insert(X, node(Y, L, R), node(Y, L, New)) :- 
    X >= Y, 
    insert(X, R, New).

inorder(Tree, List) :- inorder_acc(Tree, [], List).
inorder_acc(empty, Acc, Acc).
inorder_acc(node(X, L, R), Acc, Result) :-
    inorder_acc(R, Acc, RAcc),
    inorder_acc(L, [X|RAcc], Result).

preorder(Tree, List) :- preorder_acc(Tree, [], List).
preorder_acc(empty, Acc, Acc).
preorder_acc(node(X, L, R), Acc, [X|Result]) :-
    preorder_acc(R, Acc, RAcc),
    preorder_acc(L, RAcc, Result).

height(empty, 0).
height(node(_, L, R), H) :-
    height(L, A), 
    height(R, B), 
    H is 1 + max(A, B).

print_nums([]) :- !, nl.
print_nums(Ns) :- 
    atomic_list_concat(Ns, ' ', Text), 
    writeln(Text).
