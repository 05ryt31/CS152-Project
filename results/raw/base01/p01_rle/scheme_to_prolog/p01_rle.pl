:- use_module(library(lists)).
:- use_module(library(readutil)).

p01_rle :-
    read_line_to_string(current_input, Line),
    encode(Line, Encoded),
    format('~s~n', [Encoded]),
    halt(0).

encode([], "").
encode([H|T], Encoded) :-
    encode_loop(T, H, 1, "", Acc),
    reverse(Acc, Reversed),
    atom_chars(Result, Reversed),
    atom_concat(H, Result, Encoded).

encode_loop([], _, _, Acc, Acc).
encode_loop([H|T], Current, Count, Acc, Result) :-
    (   H =:= Current
    ->  NewCount is Count + 1,
        encode_loop(T, Current, NewCount, Acc, Result)
    ;   atom_chars(CurrentStr, [Current]),
        atom_chars(CountStr, [Count]),
        atom_concat(CurrentStr, CountStr, Pair),
        encode_loop(T, H, 1, [Pair | Acc], Result)
    ).
