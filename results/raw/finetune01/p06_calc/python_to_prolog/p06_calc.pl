 
:- use_module(library(lambda)).
 
% parse the string into a list of tokens
parse(String, Tokens) :-
	string_chars(String, Chars),
	atom_chars(Chars, Tokens).
 
% convert a list of tokens into a list of terms
tokenize(Tokens, Terms) :-
	maplist(\X^(number(X) -> [X] ; X), Tokens, Tokenized),
	group_pairs_by_key(Tokenized, Grouped),
	maplist(\X^sort(X, _), Grouped, Sorted),
	maplist(\X^append(X, Y), Sorted, Terms).
 
% evaluate a list of terms
evaluate(Terms, Result) :-
	evaluate(Terms, 0, Result).
evaluate([], Result, Result).
evaluate([+ Term | Rest], Acc, Result) :-
	evaluate(Rest, Acc + Term, Result).
evaluate([- Term | Rest], Acc, Result) :-
	evaluate(Rest, Acc - Term, Result).
evaluate([* Term | Rest], Acc, Result) :-
	evaluate(Rest, Acc * Term, Result).
evaluate([Term | Rest], Term, Result) :-
	evaluate(Rest, Term, Result).
 
% calculate the result of a string
calculate(String, Result) :-
	parse(String, Tokens),
	tokenize(Tokens, Terms),
	evaluate(Terms, Result).
 
