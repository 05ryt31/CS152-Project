 
:- use_module(library(lambda)).
 
% rle("aaabbbcccc", X).
% X = [('a',3),('b',3),('c',4)].
rle(L, RLE) :-
	map_list_to_pairs(\X^Y^(length(X, Y)), L, Pairs),
	group_pairs_by_key(Pairs, RLE).
 
