:- use_module(library(readutil)).

apply_stage([], _, _).
apply_stage([V | Rest], ["map", "add", Amount], Result) :-
    NewV is V + Amount,
    apply_stage(Rest, ["map", "add", Amount], Tail),
    append([NewV], Tail, Result).
apply_stage([V | Rest], ["map", "mul", Amount], Result) :-
    NewV is V * Amount,
    apply_stage(Rest, ["map", "mul", Amount], Tail),
    append([NewV], Tail, Result).
apply_stage([V | Rest], ["filter", "even"], Result) :-
    V mod 2 =:= 0,
    apply_stage(Rest, ["filter", "even"], Tail),
    append([V], Tail, Result).
apply_stage([V | Rest], ["filter", "odd"], Result) :-
    V mod 2 =\= 0,
    apply_stage(Rest, ["filter", "odd"], Tail),
    append([V], Tail, Result).
apply_stage([V | Rest], ["filter", "gt", Amount], Result) :-
    V > Amount,
    apply_stage(Rest, ["filter", "gt", Amount], Tail),
    append([V], Tail, Result).
apply_stage(_, ["reduce", "sum"], Total) :-
    sum_list(Total, 0).
apply_stage([Best], _, Best) :-
    !.
apply_stage([V | Rest], _, Best) :-
    V > Best,
    apply_stage(Rest, _, Best).

p11_pipeline :-
    read_line_to_string(current_input, Line),
    string_codes(Line, Codes),
    Tokens =.. [tokens|Codes],
    maplist(string_to_integer, Tokens, Values),
    read_line_to_string(current_input, KLine),
    string_codes(KLine, KCodes),
    integer_string(K, KCodes),
    process_stages(Values, K, []),
    !,
    halt.

process_stages(_, 0, Values) :-
    format("~w~n", [Values]).
process_stages(Values, K, Acc) :-
    read_line_to_string(current_input, StageLine),
    string_codes(StageLine, StageCodes),
    Tokens =.. [tokens|StageCodes],
    maplist(string_to_integer, Tokens, Parts),
    apply_stage(Acc, Parts, NewAcc),
    K1 is K - 1,
    process_stages(Values, K1, NewAcc).
