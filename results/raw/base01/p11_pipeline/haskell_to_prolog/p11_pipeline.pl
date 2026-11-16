:- use_module(library(lists)).
:- use_module(library(readutil)).

apply(Xs, ["map", "add", N]) :- maplist(plus(N), Xs, Ys).
apply(Xs, ["map", "mul", N]) :- maplist(mult(N), Xs, Ys).
apply(Xs, ["filter", "even"]) :- keep_if(even, Xs, Ys).
apply(Xs, ["filter", "odd"]) :- keep_if(odd, Xs, Ys).
apply(Xs, ["filter", "gt", N]) :- keep_if(lambda(X, X > N), Xs, Ys).
apply([X], ["reduce", "sum"]) :- X = Y.
apply([], ["reduce", "max"]) :- !, fail.
apply(Xs, ["reduce", "max"]) :- max_list(Xs, Y).

read_nums(S, L) :-
    atom_codes(S, Codes),
    split_string(Codes, " ", "", Words),
    maplist(atom_number, Words, L).

p11_pipeline :-
    read_line_to_string(current_input, Values),
    read_line_to_string(current_input, KStr),
    number_string(K, KStr),
    findall(Line, (between(1, K, _), read_line_to_string(current_input, Line)), Stages),
    read_nums(Values, NumList),
    foldl(apply, Stages, NumList, Result),
    (   Result = [],
        member("reduce", LastStage),
        LastStage =.. [_|Words],
        member("max", Words)
    ->
        format('none~n')
    ;
        Result \= [],
        maplist(number_string, Result, StrList),
        format('~w~n', [StrList])
    ),
    halt.

number_string(N, S) :-
    number_codes(N, Codes),
    atom_codes(S, Codes).

keep_if(Pred, [], []) :- !.
keep_if(Pred, [H|T], [H|RT]) :-
    Pred(H),
    keep_if(Pred, T, RT).
keep_if(Pred, [_|T], RT) :-
    keep_if(Pred, T, RT).

mult(N, X, Y) :-
    Y is X * N.

plus(N, X, Y) :-
    Y is X + N.

max_list([X], X) :- !.
max_list([H|T], M) :-
    max_list(T, TM),
    (   H > TM
    ->
        M = H
    ;
        M = TM
    ).

lambda(_, true) :- !.
lambda(X, P) :-
    call(P, X).
