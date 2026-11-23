 
:- use_module(library(lambda)).
 
remove_duplicates(L, L1) :-
	sort(L, L1).
 
remove_duplicates_2(L, L1) :-
	remove_duplicates_(L, [], L1).
 
remove_duplicates_([], _, []):-!.
remove_duplicates_([H|T], Seen, R) :-
	member(H, Seen),
	!,
	remove_duplicates_(T, Seen, R).
remove_duplicates_([H|T], Seen, [H|R]) :-
	\+ member(H, Seen),
	append([H], Seen, Seen1),
	remove_duplicates_(T, Seen1, R).
 
