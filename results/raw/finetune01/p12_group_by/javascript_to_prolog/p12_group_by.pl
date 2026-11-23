:- use_module(library(lambda)).
 
% Group elements of list L by Key(K), where K is computed by function F.
% Result is grouped list in form of pairs [Key, ListOfElements].
group_by(F, L, G) :-
	maplist(\X^Y^(call(F, X, Y)), L, KL),
	predsort(\X^Y^Z^(compare(Z, X#Y)), KL, S),
	group_pairs_by_key(S, G).
 
% Test case
test_case([a, b, c], [1, 2, 3]).
 
main :-
	test_case(L, K),
	group_by(\X^Y^(length(X, Y)), L, R),
	format('Input: ~w~n', [L]),
	format('Output: ~w~n', [R]).
 
