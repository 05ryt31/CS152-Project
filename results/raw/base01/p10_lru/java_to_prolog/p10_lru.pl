:- use_module(library(lists)).
:- use_module(library(readutil)).

p10_lru :-
    read_line_to_string(current_input, CapacityStr),
    string_to_integer(CapacityStr, Capacity),
    read_line_to_string(current_input, NStr),
    string_to_integer(NStr, N),
    lru_cache(Capacity, N, Cache),
    format('~w~n', [Cache]),
    halt.

lru_cache(_, _, []) :- !.
lru_cache(Capacity, N, Cache) :-
    findall([Key, Value], (between(0, N, _), read_line_to_string(current_input, Line), parse_line(Line, Key, Value)), Lines),
    process_lines(Lines, Capacity, [], Cache).

parse_line(Line, Key, Value) :-
    atom_codes(Line, Codes),
    split_string(Codes, ' ', '', Parts),
    nth0(0, Parts, Action),
    nth0(1, Parts, KeyStr),
    string_to_integer(KeyStr, Key),
    (   Action == 'put' ->
        nth0(2, Parts, ValueStr),
        string_to_integer(ValueStr, Value)
    ;   Action == 'get' ->
        Value = -1
    ).

process_lines([], _, Acc, Acc).
process_lines([[Action, Key, Value]|T], Capacity, Acc, Cache) :-
    (   Action == 'get' ->
        (   member([Key, _], Acc) ->
            format('~w~n', [Value])
        ;   format('-1~n')
        )
    ;   Action == 'put' ->
        (   member([Key, _], Acc) ->
            NewAcc = [Key-Value|remove_key(Key, Acc)]
        ;   NewAcc = [Key-Value|Acc]
        ),
        length(NewAcc, Length),
        (   Length > Capacity ->
            LastKey-LastValue = last(NewAcc),
            NewAcc = [NewKey-NewValue|remove_last(NewAcc)],
            lru_cache(Capacity, N, NewAcc)
        ;   lru_cache(Capacity, N, NewAcc)
        )
    ),
    process_lines(T, Capacity, NewAcc, Cache).

remove_key(Key, [Key-_|T]) :- !, T.
remove_key(Key, [H|T]) :-
    remove_key(Key, T).

remove_last([_]) :- !, [].
remove_last([H|T]) :-
    remove_last(T).

last([H|T]) :-
    (   T = [] -> H
    ;   last(T)
    ).
