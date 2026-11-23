pipeline :-
	L = [1,2,3,4,5],
	pipe(L, "map add 2", L1),
	pipe(L1, "filter even", L2),
	pipe(L2, "reduce sum", L3),
	writeln(L3).
 
pipe(In, Stage, Out) :-
	read_stage(Stage, F),
	maplist(F, In, Out).
 
read_stage("map add N", F) :- read_number(N), F = map_add(N).
read_stage("filter even", F) :- F = filter_even.
read_stage("reduce sum", F) :- F = reduce_sum.
 
map_add(N)(X, Y) :- Y is X + N.
filter_even(X, true) :- 0 is X mod 2.
filter_even(_, false).
reduce_sum([X], Y) :- Y is X.
reduce_sum([X|T], Z) :- reduce_sum(T, Y), Z is X + Y.
