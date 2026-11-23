 
:- use_module(library(lambda)).
 
remove_duplicates(L, L1) :-
	sort(L, L1).
 
