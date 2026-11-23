 
:- use_module(library(lambda)).
 
% parse the string into a list of tokens
parse(String, Tokens) :-
	string_chars(String, Chars),
	atom_chars(Tokens, Chars),
	split_tokens(Tokens, Tokens1),
	Tokens1 \= [],
	last(Tokens1, Token),
	Token \= end,
	maplist(check_token, Tokens1).
 
check_token(Token) :-
	member(Token, [end, plus, minus, times, divide]),
	!.
check_token(Token) :-
	number(Token).
 
% split up the tokens into a list of expressions
split_tokens([], []).
split_tokens([Token|Tokens], [Expression|Expressions]) :-
	extract_expression(Token, Tokens, Expression, Rest),
	split_tokens(Rest, Expressions).
 
extract_expression(end, [], [], []).
extract_expression(Token, Tokens, Expression, Rest) :-
	Token \= end,
	extract_expression(Token, Tokens, Expression, Rest).
extract_expression(Token, [Token1|Rest1], Expression, Rest) :-
	extract_expression(Token1, Rest1, Expression, Rest).
 
extract_expression(Token, [plus|Rest], Expression, Rest) :-
	Token \= end,
	Token \= plus,
	Token \= minus,
	Token \= times,
	Token \= divide,
	!,
	Expression = [Token].
extract_expression(Token, [minus|Rest], Expression, Rest) :-
	Token \= end,
	Token \= plus,
	Token \= minus,
	Token \= times,
	Token \= divide,
	!,
	Expression = [-Token].
extract_expression(Token, [times|Rest], Expression, Rest) :-
	Token \= end,
	Token \= plus,
	Token \= minus,
	Token \= times,
	Token \= divide,
	!,
	Expression = [[times, Token]].
extract_expression(Token, [divide|Rest], Expression, Rest) :-
	Token \= end,
	Token \= plus,
	Token \= minus,
	Token \= times,
	Token \= divide,
	!,
	Expression = [[divide, Token]].
extract_expression(Token, [plus|Rest], Expression, Rest1) :-
	Token \= end,
	Token \= plus,
	Token \= minus,
	Token \= times,
	Token \= divide,
	!,
	extract_expression(Token, Rest, Expression, Rest1).
extract_expression(Token, [minus|Rest], Expression, Rest1) :-
	Token \= end,
	Token \= plus,
	Token \= minus,
	Token \= times,
	Token \= divide,
	!,
	extract_expression(Token, Rest, Expression, Rest1).
extract_expression(Token, [times|Rest], Expression, Rest1) :-
	Token \= end,
	Token \= plus,
	Token \= minus,
	Token \= times,
	Token \= divide,
	!,
	extract_expression(Token, Rest, Expression, Rest1).
extract_expression(Token, [divide|Rest], Expression, Rest1) :-
	Token \= end,
	Token \= plus,
	Token \= minus,
	Token \= times,
	Token \= divide,
	!,
	extract_expression(Token, Rest, Expression, Rest1).
extract_expression(Token, [end|Rest], Expression, Rest) :-
	Token \= end,
	Token \= plus,
	Token \= minus,
	Token \= times,
	Token \= divide,
	!,
	Expression = [Token].
extract_expression(Token, [end|_], Expression, []) :-
	Token \= end,
	Token \= plus,
	Token \= minus,
	Token \= times,
	Token \= divide,
	!,
	Expression = [Token].
extract_expression(Token, [_|Rest], Expression, Rest1) :-
	Token \= end,
	Token \= plus,
	Token \= minus,
	Token \= times,
	Token \= divide,
	!,
	extract_expression(Token, Rest, Expression, Rest1).
 
% evaluate the list of expressions
evaluate(Expression, Value) :-
	evaluate(Expression, 0, Value).
 
evaluate([], Value, Value).
evaluate([[plus, Expression]|Expressions], Value, Result) :-
	evaluate(Expression, Value, V),
	V1 is Value + V,
	evaluate(Expressions, V1, Result).
evaluate([[minus, Expression]|Expressions], Value, Result) :-
	evaluate(Expression, Value, V),
	V1 is Value - V,
	evaluate(Expressions, V1, Result).
evaluate([[times, Expression]|Expressions], Value, Result) :-
	evaluate(Expression, Value, V),
	V1 is Value * V,
	evaluate(Expressions, V1, Result).
evaluate([[divide, Expression]|Expressions], Value, Result) :-
	evaluate(Expression, Value, V),
	V1 is Value / V,
	evaluate(Expressions, V1, Result).
evaluate([Expression|Expressions], Value, Result) :-
	evaluate(Expression, Value, V),
	evaluate(Expressions, V, Result).
 
% calculate the result of the string
calculate(String, Result) :-
	parse(String, Tokens),
	split_tokens(Tokens, Expressions),
	evaluate(Expressions, Result).
 
