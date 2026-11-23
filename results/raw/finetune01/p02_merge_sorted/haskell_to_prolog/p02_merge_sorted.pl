 
:- use_module(library(lambda)).
 
% merge sorted lists
merge_sorted([], _, []).
merge_sorted(_, [], []).
merge_sorted([X|T1], [Y|T2], L) :-
	X < Y,
	!,
	merge_sorted(T1, [Y|T2], L1),
	L = [X|L1].
merge_sorted([X|T1], [Y|T2], L) :-
	merge_sorted([X|T1], T2, L1),
	L = [Y|L1].
 
% test
test :-
	L1 = [1,3,5],
	L2 = [2,4,6],
	merge_sorted(L1, L2, L),
	writeln('Merged list : '),
	write(L), nl.
 
