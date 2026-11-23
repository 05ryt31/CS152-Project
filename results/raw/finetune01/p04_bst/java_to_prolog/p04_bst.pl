bst_tree([5,3,7,1,4,6,8]).
 
% Task 1
insert_node(T, V, T1):-
    bst_tree(T),
    insert(V, T, T1).
 
insert(V, [], [V]):-!.
insert(V, [X|T], [X|T1]):-
    V >= X,
    !,
    insert(V, T, T1).
insert(V, [X|T], [V,X|T]):-
    V < X.
 
% Task 2
inorder([], []):-!.
inorder([X], [X]):-!.
inorder([X|T], L):-
    inorder(T, R),
    inorder(X, R).
 
inorder(X, L):-
    integer(X),
    L = [X].
 
inorder([X|T], L):-
    inorder(X, L1),
    inorder(T, L2),
    append(L1, L2, L).
 
preorder([], []):-!.
preorder([X], [X]):-!.
preorder([X|T], L):-
    preorder(X, L1),
    preorder(T, L2),
    append(L1, L2, L3),
    append([X], L3, L).
 
height([], 0):-!.
height([_], 1):-!.
height([_|T], H):-
    height(T, H1),
    H is H1 + 1.
 
