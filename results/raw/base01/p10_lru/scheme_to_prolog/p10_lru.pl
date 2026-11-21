:- use_module(library(lists)).
:- use_module(library(readutil)).

find_value(Key, Entries) :-
    member((Key, Value), Entries),
    !,
    Value.
find_value(_, _).

remove_key(Key, [], []).
remove_key(Key, [(Key, _) | Tail], Tail).
remove_key(Key, [Head | Tail], [Head | NewTail]) :-
    remove_key(Key, Tail, NewTail).

remove_from_order(Key, [], []).
remove_from_order(Key, [Key | Tail], Tail).
remove_from_order(Key, [Head | Tail], [Head | NewTail]) :-
    remove_from_order(Key, Tail, NewTail).

touch(Key, Order) :-
    append(Removed, [Key], Order),
    Removed = [_].

lru(Capacity, N) :-
    lru_loop(0, [], [], Capacity, N).

lru_loop(I, Entries, Order, _, _) :-
    I =:= N,
    !.
lru_loop(I, Entries, Order, Capacity, N) :-
    read_line_to_string(Input),
    split_string(Input, Parts, " "),
    Op = Parts[0],
    Key = Parts[1],
    (   Op == "get" ->
        (   find_value(Key, Entries) = Value ->
            format('~d~n', [Value]),
            NewOrder = (touch(Key, Order))
        ;   format('-1~n'),
            NewOrder = Order
        ),
        lru_loop(Succ, Entries, NewOrder, Capacity, N)
    ;   Value = Parts[2],
        (   find_value(Key, Entries) = (Key, ExistingValue) ->
            NewEntries = Entries,
            NewOrder = touch(Key, Order)
        ;   NewEntries = [(Key, Value) | remove_key(Key, Entries)],
            NewOrder = touch(Key, Order)
        ),
        (   length(NewOrder) > Capacity ->
            Oldest = NewOrder[0],
            NewEntries = remove_key(Oldest, NewEntries),
            NewOrder = NewOrder[1..]
        ;   true
        ),
        lru_loop(Succ, NewEntries, NewOrder, Capacity, N)
    ),
    Succ is I + 1.

p10_lru :-
    read_line_to_string(Input),
    Capacity = Input,
    read_line_to_string(Input),
    N = Input,
    lru(Capacity, N),
    halt.
