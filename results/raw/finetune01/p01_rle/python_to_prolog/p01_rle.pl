 
:- use_module(library(lambda)).
 
% rle("aaabbbcccc", X).
% X = [('a',3),('b',3),('c',4)].
rle(L, RLE) :-
	group_pairs_by_key(L, G),
	map_list_to_pairs(\X^Y^(length(Y, L), X = (X, L)), G, RLE).
 
