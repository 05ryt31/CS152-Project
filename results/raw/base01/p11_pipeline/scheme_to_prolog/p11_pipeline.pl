:- use_module(library(lists)).
:- use_module(library(readutil)).

numbers(Line, Values) :-
    Line = "",
    Values = [].
numbers(Line, Values) :-
    split_string(Line, " ", "", Tokens),
    maplist(string_to_number, Tokens, Values).

sum([], 0).
sum([H|T], Sum) :-
    sum(T, TailSum),
    Sum is H + TailSum.

maximum([], none).
maximum([H], H).
maximum([H|T], Max) :-
    maximum(T, TailMax),
    (   TailMax == none -> Max = H ;
        Max is max(H, TailMax)
    ).

keep(_, [], []).
keep(Pred, [H|T], [H|Rest]) :-
    Pred(H),
    keep(Pred, T, Rest).
keep(Pred, [_|T], Rest) :-
    keep(Pred, T, Rest).

apply_stage(Values, Parts) :-
    Parts = [Kind, Name],
    (   Kind == "map" ->
        Parts = ["map", _, Amount],
        (   Name == "add" ->
            maplist(lambda(X, X + Amount), Values, Result);
            maplist(lambda(X, X * Amount), Values, Result)
        );
        Parts = ["filter", _, _] ->
        (   Name == "even" -> keep(even, Values, Result);
            Name == "odd" -> keep(odd, Values, Result);
            Parts = ["filter", _, Threshold] ->
            keep(lambda(X, X > string_to_number(Threshold)), Values, Result)
        );
        Parts = ["sum"] -> sum(Values, Result);
        Result = none;
        maximum(Values, Result)
    ),
    Result.

pipeline(K, Values) :-
    pipeline(K, Values, 0).

pipeline(_, [], _).
pipeline(K, Values, I) :-
    I < K,
    read_line(InputLine),
    apply_stage(Values, InputParts),
    pipeline(K, NewValues, I + 1),
    !,
    (   NewValues \= none ->
        (   list(NewValues) ->
            (   NewValues = [] -> true ;
                display(car(NewValues)),
                maplist(lambda(X, format("~d ", X)), cdr(NewValues)),
                nl
            )
        ;   print(NewValues)
        )
    ;   true
    ).

p11_pipeline :-
    read_line_to_string(current_input, Line),
    numbers(Line, Values),
    read_line_to_string(current_input, KLine),
    string_to_number(KLine, K),
    pipeline(K, Values),
    halt.
