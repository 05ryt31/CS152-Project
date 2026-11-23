 
:- initialization(main, main).
 
main([K|T]) :-
	read_line_to_string(user_input, Line),
	atom_codes(Line, Codes),
	split_string(Codes, "\n", "", [Line1]),
	atomic_list_concat(Lines, '\n', Line1),
	maplist(my_read_line_to_string, Lines, Lst),
	pipeline(K, T, Lst).
 
my_read_line_to_string(String, Term) :-
	read_string(String, _, String1, _),
	string_to_atom(String1, Atom),
	number_string(Term, Atom).
 
pipeline(0, _, Lst) :-
	writef('None\n'),
	writeln(Lst).
pipeline(N, Predicates, Lst) :-
	N > 0,
	length(Predicates, Len),
	Len >= N,
	nth0(N, Predicates, Predicate),
	call(Predicate, Lst, Lst1),
	N1 is N - 1,
	pipeline(N1, Predicates, Lst1).
pipeline(_, _, _).
 
% map
map_add(X, Y, Z) :- Z is X + Y.
map_mul(X, Y, Z) :- Z is X * Y.
 
% filter
filter_even(X, Y) :- Y is X mod 2.
filter_odd(X, Y) :- Y \= X mod 2.
filter_gt(X, Y, Z) :- Z is X > Y.
 
% reduce
reduce_sum([], 0).
reduce_sum([X], X).
reduce_sum([H|T], Sum) :-
	reduce_sum(T, Sum1),
	Sum is H + Sum1.
 
