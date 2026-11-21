:- use_module(library(lists)).
:- use_module(library(readutil)).

p06_calc :-
    read_line_to_string(current_input, Input),
    Output is calc(Input),
    format('~w~n', [Output]),
    halt(0).

calc(Str) :-
    Tokens = tokenize(Str),
    parse_expr(Tokens, Result),
    !,
    Result.

tokenize(Str) :-
    string_codes(Str, Codes),
    tokenize(Codes, [], Tokens).

tokenize([], _, []) :- !.
tokenize([C | Cs], Acc, Tokens) :-
    char_whitespace(C), !,
    tokenize(Cs, Acc, Tokens).
tokenize([C | Cs], Acc, Tokens) :-
    char_numeric(C), !,
    number_loop(Cs, [C | Acc], NewAcc),
    reverse(NewAcc, Num),
    tokenize(Cs, [], [Num | Tokens]).
tokenize([C | Cs], Acc, Tokens) :-
    tokenize(Cs, [C | Acc], Tokens).

number_loop([], Acc, Acc) :- !.
number_loop([C | Cs], Acc, NewAcc) :-
    char_numeric(C), !,
    number_loop(Cs, [C | Acc], NewAcc).
number_loop(_, Acc, Acc) :- !.

parse_expr(Tokens, Result) :-
    parse_term(Tokens, TermResult, Rest1),
    parse_expr(Rest1, ExprResult, Rest2),
    !,
    Result is TermResult + ExprResult.

parse_expr(Rest, Result, Rest) :-
    !,
    Result is 0.

parse_term(Tokens, Result, Rest) :-
    parse_factor(Tokens, FactorResult, Rest1),
    parse_term(Rest1, TermResult, Rest2),
    !,
    Result is FactorResult * TermResult.

parse_term(Rest, Result, Rest) :-
    !,
    Result is 0.

parse_factor(Tokens, Result, Rest) :-
    number(Tokens, Result, Rest), !.
parse_factor(Tokens, Result, Rest) :-
    Tokens = [_ | Rest],
    parse_expr(Rest, Result, _).

number([N | _], N, []) :-
    number(N), !.
number([H | T], Result, Rest) :-
    number(H), number_codes(Result, [H | T]), !,
    Rest = [].
