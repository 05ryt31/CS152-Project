:- use_module(library(lambda)).
 
group_by :-
	L = ["a 5", "b 3", "a 7", "c 4", "b 9"],
	group_pairs(L, L1),
	map_list_to_pairs(\X^Y^(atom_codes(X, Y)), L1, L2),
	pairs_values(L2, V),
	sort(V, VS),
	map_list_to_pairs(\X^Y^(length(Y, X)), VS, LV),
	map_list_to_pairs(\X^Y^(sumlist(Y, X)), LV, LVS),
	map_list_to_pairs(\X^Y^(pairing(X, Y)), LVS, LVP),
	map_list_to_pairs(\X^Y^(concat(X, Y)), LVP, LVC),
	map_list_to_pairs(\X^Y^(string_concat(X, ' ', Y)), LVC, LVD),
	writeln(LVD).
 
% group pairs
group_pairs([], []):-!.
group_pairs([H|T], R):-
	atom_codes(K, H),
	atom_codes(V, Tmp),
	number_codes(N, Tmp),
	group_pairs(T, RT),
	(   member([K, NV], RT) ->
	     N1 is N+NV,
	     R = [[K, N1]|RT]
	;   R = [[K, N]|RT]).
 
% pairing
pairing(K, V):-
	string_concat(K, ' ', S1),
	string_concat(S1, ':', S2),
	string_concat(S2, V, S3),
	string_concat(S3, '\n', S4),
	pairing(K, V, S4).
 
pairing(_, [], ''):-!.
pairing(K, [H|T], R):-
	string_concat(K, ' ', S1),
	string_concat(S1, H, S2),
	string_concat(S2, '\t', S3),
	pairing(K, T, ST),
	string_concat(ST, S3, R).
 
