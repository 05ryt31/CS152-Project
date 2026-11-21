:- use_module(library(readutil)).
:- use_module(library(lists)).

p10_lru :-
    read_line_to_string(current_input, CapacityStr),
    string_to_integer(CapacityStr, Capacity),
    read_line_to_string(current_input, NStr),
    string_to_integer(NStr, N),
    init_cache(Capacity, Cache, Order),
    process_requests(N, Cache, Order, []),
    halt.

init_cache(_, [], []).

process_requests(0, _, _, _) :- !.

process_requests(N, Cache, Order, Acc) :-
    read_line_to_string(current_input, Line),
    parse_request(Line, Request),
    handle_request(Request, Cache, Order, NewCache, NewOrder),
    process_requests(N-1, NewCache, NewOrder, [Request|Acc]).

parse_request(Line, Request) :-
    split_string(Line, ' ', '', Parts),
    Request =.. Parts.

handle_request(['get', Key], Cache, Order, Cache, NewOrder) :-
    member(Key, Order), !,
    remove_all_but_last(Order, Key, NewOrder).
handle_request(['get', _], _, Order, _, Order) :-
    !.
handle_request(['set', Key, Value], Cache, Order, NewCache, NewOrder) :-
    (   member(Key, Order)
    ->  remove_all_but_last(Order, Key, NewOrder),
        Cache = [Value|Rest],
        NewCache = [Value|Rest]
    ;   length(Order, Len),
        Len < Cap,
        NewOrder = [Key|Order],
        NewCache = [Value|Cache]
    ;   remove_first(Order, Oldest),
        remove_key_value(Cache, Oldest, NewCache),
        NewOrder = [Key|Order],
        NewCache = [Value|NewCache]
    ).

remove_all_but_last([H|T], H, T).

remove_first([], _, []).

remove_first([H|T], H, T).

remove_key_value([], _, []).

remove_key_value([K|V], K, V).

remove_key_value([K|V], Key, [K|NV]) :-
    remove_key_value(V, Key, NV).
