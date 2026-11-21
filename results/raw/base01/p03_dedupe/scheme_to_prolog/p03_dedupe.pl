:- use_module(library(lists)).
:- use_module(library(readutil)).

p03_dedupe :-
    read_line_to_string(current_input, Line),
    Numbers = [N | _] ^ numbers(Line, N),
    Deduped = [D | _] ^ dedupe(Numbers, []),
    print_list(Deduped),
    halt.

numbers("", []).
numbers(Line, [N | Rest]) :-
    split_string(Line, " ", "", Parts),
    maplist(string_number, Parts, [N | Rest]).

string_number(S, N) :-
    number_string(N, S).

dedupe([], _Seen, []).
dedupe([H | T], Seen, [H | Deduped]) :-
    \+ member(H, Seen),
    dedupe(T, [H | Seen], Deduped).
dedupe([_ | T], Seen, Deduped) :-
    dedupe(T, Seen, Deduped).

print_list([]).
print_list([H | T]) :-
    format('~d', H),
    (   T = []
    ->  nl
    ;   format(' ~d', T),
        nl
    ).

safe_read_line :-
    read_line_to_string(current_input, Line),
    (   Line = ""
    ->  safe_read_line
    ;   Line = Line
    ).
