groupby :-
	L = ["a"-"b", "c"-"d", "e"-"f", "a"-"g", "c"-"h"],
	group_pairs(L, L1),
	map_list_to_pairs(count, L1, L2),
	map_list_to_pairs(keyof, L2, L3),
	predsort(my_compare, L3, L4),
	map_list_to_pairs(remake, L4, L5),
	map_list_to_pairs(pair, L5, L6),
	map_list_to_pairs(join, L6, L7),
	map_list_to_pairs(print, L7, _).
 
my_compare(R, A, B) :- compare(R, A, B), !.
my_compare(_R, _, _).
 
pair([K-V1,V2], K-V1-V2).
join([K-V1-V2], V1-V2-K).
print([V1-V2-K], W) :- format('~w ~w ~w~n', [K, V1, V2]), W is V2+1.
 
keyof([K-_V1-_V2], K).
count([_K-V1], V2) :- V2 is V1+1.
remake([V1-V2-K], V3) :- V3 is V2*1000+K.
 
