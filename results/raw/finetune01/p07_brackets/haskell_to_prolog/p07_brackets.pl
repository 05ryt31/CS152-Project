:- use_module(library(clpfd)).
 
% Brackets in order of opening
bracket_pairs(['(', ')'], ['[', ']'], ['{', '}']).
 
% Check if brackets are balanced
balanced_brackets(String) :-
	bracket_pairs(OpenBrackets, CloseBrackets),
	% Create lists of open and close brackets
	extract_brackets(String, OpenBrackets, OpenList),
	extract_brackets(String, CloseBrackets, CloseList),
	% Ensure there are no extra closing brackets
	length(CloseList, NClose),
	length(OpenList, NOpen),
	NClose #= NOpen,
	% Ensure all open brackets have corresponding closing bracket
	maplist(has_corresponding_close(OpenList), CloseBrackets, CloseList).
 
% Extract brackets from string
extract_brackets(String, BracketPairs, BracketList) :-
	extract_brackets(String, BracketPairs, [], BracketList).
extract_brackets([], _, BracketList, BracketList).
extract_brackets([X|Rest], [OpenBracket|BracketPairs], BracketList, BracketListResult) :-
	X == OpenBracket,
	extract_brackets(Rest, BracketPairs, [OpenBracket|BracketList], BracketListResult).
extract_brackets([_|Rest], [_|BracketPairs], BracketList, BracketListResult) :-
	extract_brackets(Rest, BracketPairs, BracketList, BracketListResult).
 
% Check if open bracket has corresponding closing bracket
has_corresponding_close(OpenList, CloseBracket, CloseBracketList) :-
	member(CloseBracket, CloseBracketList),
	index_of(CloseBracketList, CloseBracket, Index),
	nth0(Index, OpenList, OpenBracket),
	close_bracket(CloseBracket, OpenBracket).
 
% Get index of element in list
index_of(List, Element, Index) :-
	index_of(List, Element, 0, Index).
index_of([], _, Index, Index).
index_of([Element|_], Element, Index, Index).
index_of([_|Rest], Element, Index, Result) :-
	Index #> 0,
	Index1 #= Index + 1,
	index_of(Rest, Element, Index1, Result).
 
% Check if brackets match
close_bracket(')', '(').
close_bracket(']', '[').
close_bracket('}', '{').
 
