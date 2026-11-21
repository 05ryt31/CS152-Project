:- use_module(library(lists)).
:- use_module(library(readutil)).

touch(Key, Order) :-
    exclude(==(Key), Order, NewOrder),
    append(NewOrder, [Key], Result),
    Result.

apply((Values, Order), Line, ((FinalValues, FinalOrder), Output)) :-
    atom_codes(Line, Codes),
    split_string(Codes, " ", "", Words),
    process_command(Words, Values, Order, FinalValues, FinalOrder, Output).

process_command(["get", K], Values, Order, Values, Order, "-1") :-
    number_string(K, Key),
    \+ member(Key, Values).
process_command(["get", K], Values, Order, Values, Order, Value) :-
    number_string(K, Key),
    member(Key, Values),
    Values =.. [_|Pairs],
    find_value(Pairs, Key, Value).
process_command(["put", K, V], Values, Order, FinalValues, FinalOrder, _) :-
    number_string(K, Key),
    number_string(V, Val),
    touch(Key, Order, NewOrder),
    (   NewOrder = [Oldest|_],
        not(member(Key, Values)),
        length(NewOrder) > Cap,
        delete(Values, Oldest, UpdatedValues),
        FinalValues = UpdatedValues,
        FinalOrder = NewOrder
    ;
        FinalValues = Values,
        FinalOrder = NewOrder
    ).
process_command(_, _, _, _, _, _).

find_value([K-V|_], K, V) :- !.
find_value(_-V|Pairs, K, V) :-
    find_value(Pairs, K, V).

runLRU(Cap, Commands, Outputs) :-
    maplist(apply((empty_dict, [])), Commands, RawOutputs),
    cat_maybes(RawOutputs, Outputs).

p10_lru :-
    read_line_to_string(current_input, Cap),
    read_line_to_string(current_input, N),
    read_n_lines(N, current_input, Commands),
    runLRU(Cap, Commands, Outputs),
    format("~s~n", [string_concat(Outputs, "\n")]),
    halt.

read_n_lines(0, _, _) :- !.
read_n_lines(N, Stream, [Line|Lines]) :-
    read_line_to_string(Stream, Line),
    M is N - 1,
    read_n_lines(M, Stream, Lines).

:- initialization(p10_lru).
