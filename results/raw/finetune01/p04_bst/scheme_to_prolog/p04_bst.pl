bst_insert(T, V, T1):-
	bst_insert(V, T, T1).
 
bst_insert(V, t(K,L,R), t(K,L1,R)):-
	V < K,
	bst_insert(V, L, L1).
bst_insert(V, t(K,L,R), t(K,L,R1)):-
	V >= K,
	bst_insert(V, R, R1).
bst_insert(V, _, t(V,nil,nil)).
 
% inorder traversal
bst_inorder(t(_,L,_), L1):-
	bst_inorder(L, L1).
bst_inorder(t(_,_,R), L1):-
	bst_inorder(R, L2),
	append(L1, [V], L2),
	 bst_inorder(V).
 
bst_preorder(t(V,L,R), L1):-
	append([V], L2, L1),
	bst_preorder(L, L2),
	bst_preorder(R, L3),
	append(L3, [], L2).
 
bst_height(nil, 0):-!.
bst_height(t(_,L,R), H):-
	bst_height(L, HL),
	bst_height(R, HR),
	H is max(HL,HR)+1.
 
