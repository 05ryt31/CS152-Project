 
:- use_module(library(lambda)).
 
% rle("aaabbbcccc", L).
rle(S, L) :-
	maplist(rle_of_char(S), L).
 
% rle_of_char("aaabbbcccc", \X^Y^(char_type(X, alpha), rle_of_char(X, S, Y))).
rle_of_char(S, X-Y) :-
	char_type(X, alpha),
	rle_of_char(S, X, Y).
 
% rle_of_char("aaabbbcccc", 'a', 3).
rle_of_char([], _, 0).
rle_of_char([X|_], X, N) :- 
	\+ char_type(X, alpha).
rle_of_char([X|T], X, N) :-
	rle_of_char(T, X, N1),
	N is N1 + 1.
rle_of_char([X|_], Y, N) :-
	X \= Y,
	N is 0.
 
