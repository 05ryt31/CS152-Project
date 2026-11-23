:- use_module(library(lambda)).
 
% Task 1
group_pairs :-
	L = [(a, 4), (b, 6), (a, 6), (c, 1), (b, 2)],
	group_pairs(L, L1),
	map_list_to_name(L1, N),
	predsort(my_compare, N, L2),
	format('Grouped pairs: ~w~n', [L2]).
 
my_compare(R, A, B) :-
	compare(R, A, B).
 
% Task 2
group_strings :-
	L = ["aa", "abc", "bc", "cd"],
	group_strings(L, L1),
	map_list_to_name(L1, N),
	predsort(my_compare, N, L2),
	format('Grouped strings: ~w~n', [L2]).
 
% Task 3
group_integers :-
	L = [1, 2, 3, 5, 8, 13, 21],
	group_integers(L, L1),
	map_list_to_name(L1, N),
	predsort(my_compare, N, L2),
	format('Grouped integers: ~w~n', [L2]).
 
% Task 4
group_anagrams :-
	L = ["eat", "tea", "tan", "ate", "nat", "bat"],
	group_anagrams(L, L1),
	map_list_to_name(L1, N),
	predsort(my_compare, N, L2),
	format('Grouped anagrams: ~w~n', [L2]).
 
% Task 5
group_identical_lists :-
	L = [[1, 2], [3, 4], [1, 2], [5, 6], [3, 4]],
	group_identical_lists(L, L1),
	map_list_to_name(L1, N),
	predsort(my_compare, N, L2),
	format('Grouped identical lists: ~w~n', [L2]).
 
% Task 6
group_identical_terms :-
	L = [a(1, 2), b(3, 4), a(1, 2), c(5, 6), b(3, 4)],
	group_identical_terms(L, L1),
	map_list_to_name(L1, N),
	predsort(my_compare, N, L2),
	format('Grouped identical terms: ~w~n', [L2]).
 
% Predicates
 
% Task 1
group_pairs([], []).
group_pairs([H|T], R) :-
	H = (K, V),
	findall((K, V1), member((K, V1), T), L),
	sumlist(V1, V),
	group_pairs(T, R1),
	R = [(K, V)|R1].
 
% Task 2
group_strings([], []).
group_strings([H|T], R) :-
	string_chars(H, L),
	sort(L, S),
	group_strings(T, R1),
	R = [S|R1].
 
% Task 3
group_integers([], []).
group_integers([H|T], R) :-
	integer_sum(H, T, H1, T1),
	group_integers(T1, R1),
	R = [H1|R1].
 
integer_sum(N, [], N, []).
integer_sum(N, [H|T], N1, T1) :-
	N + H =:= N1,
	integer_sum(N, T, N1, T1).
integer_sum(N, [H|T], N1, [H|T1]) :-
	N + H \= N1,
	integer_sum(N, T, N1, T1).
 
% Task 4
group_anagrams([], []).
group_anagrams([H|T], R) :-
	string_chars(H, L),
	split_with_length(L, SL),
	group_anagrams(T, R1),
	R = [SL|R1].
 
split_with_length(L, SL) :-
	length(L, Len),
	string_from_char_code(S, Len),
	string_chars(S, L),
	SL = (S, L).
 
% Task 5
group_identical_lists([], []).
group_identical_lists([H|T], R) :-
	member(H, T),
	group_identical_lists(T, R).
group_identical_lists([H|T], R) :-
	\+member(H, T),
	group_identical_lists(T, R1),
	R = [H|R1].
 
% Task 6
group_identical_terms([], []).
group_identical_terms([H|T], R) :-
	member(H, T),
	group_identical_terms(T, R).
group_identical_terms([H|T], R) :-
	\+member(H, T),
	group_identical_terms(T, R1),
	R = [H|R1].
 
