:- initialization(p10_lru, main).

p10_lru :-
    read_line_to_string(user_input, CLine),
    read_line_to_string(user_input, NLine),
    number_string(C, CLine),
    number_string(N, NLine),
    run(N, C, []),
    halt.

run(0, _, _).
run(N, C, Cache) :-
    read_line_to_string(user_input, Line),
    split_string(Line, " ", " ", Parts),
    operation(Parts, C, Cache, NextCache),
    N1 is N - 1,
    run(N1, C, NextCache).

operation(["get", K], _, Cache, NextCache) :-
    number_string(Key, K),
    (   select(Key-Value, Cache, Rest)
    ->  writeln(Value),
        NextCache = [Key-Value | Rest]
    ;   writeln(-1),
        NextCache = Cache
    ).

operation(["put", K, V], 0, _, []) :-
    number_string(_, K),
    number_string(_, V), !.
operation(["put", K, V], C, Cache, NextCache) :-
    C > 0,
    number_string(Key, K),
    number_string(Value, V),
    (   select(Key-_, Cache, Rest)
    ->  NextCache = [Key-Value | Rest]
    ;   length(Cache, Len),
        (   Len >= C
        ->  append(Front, [_], Cache),
            NextCache = [Key-Value | Front]
        ;   NextCache = [Key-Value | Cache]
        )
    ).
