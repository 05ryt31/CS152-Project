:- use_module(library(lists)).
:- use_module(library(readutil)).

p08_bank :-
    read_line_to_string(current_input, N),
    number_codes(N, Number),
    bank(Number).

bank(0) :- !.
bank(N) :-
    read_line_to_string(current_input, Line),
    split_string(Line, " ", "", Parts),
    Command = Parts,
    handle_command(Command, N, 0).

handle_command(["deposit", Amount], N, Balance) :-
    number_codes(Amount, Number),
    NewBalance is Balance + Number,
    handle_command([], N, NewBalance).
handle_command(["withdraw", Amount], N, Balance) :-
    number_codes(Amount, Number),
    (Number > Balance ->
        format("error~n"),
        handle_command([], N, Balance);
     true),
    NewBalance is Balance - Number,
    handle_command([], N, NewBalance).
handle_command(_, N, Balance) :-
    format("~d~n", [Balance]),
    NewIndex is N - 1,
    handle_command([], NewIndex, Balance).

:- initialization(p08_bank).
:- halt.
