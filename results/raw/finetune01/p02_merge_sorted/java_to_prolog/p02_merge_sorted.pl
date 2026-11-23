 
merge_sorted([], _, []).
merge_sorted(_, [], []).
merge_sorted([H1|T1], [H2|T2], L) :-
	H1 =< H2,
	!,
	merge_sorted(T1, [H2|T2], R),
	L = [H1|R].
merge_sorted([H1|T1], [H2|T2], L) :-
	H1 > H2,
	!,
	merge_sorted([H1|T1], T2, R),
	L = [H2|R].
 
