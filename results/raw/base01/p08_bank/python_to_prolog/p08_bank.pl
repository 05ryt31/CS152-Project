:- use_module(library(readutil)).

p08_bank :-
    read_line_to_string(current_input, N),
    number_codes(N, Number),
    process_commands(Number).

process_commands(0) :- !.
process_commands(N) :-
    read_line_to_string(current_input, Line),
    split_string(Line, ' ', '', Parts),
    handle_command(Parts),
    M is N - 1,
    process_commands(M).

handle_command(['deposit', Amount]) :-
    number_codes(Amount, Num),
    add_balance(Num).
handle_command(['withdraw', Amount]) :-
    number_codes(Amount, Num),
    withdraw_balance(Num).
handle_command(['balance']) :-
    get_balance.

add_balance(Amount) :-
    current_output(Stream),
    tell(Stream, Amount),
    nl(Stream),
    told.

withdraw_balance(Amount) :-
    get_balance(Balance),
    NewBalance is Balance - Amount,
    (   NewBalance >= 0 ->
        set_balance(NewBalance),
        current_output(Stream),
        tell(Stream, NewBalance),
        nl(Stream),
        told
    ;   current_output(Stream),
        tell(Stream, 'error'),
        nl(Stream),
        told
    ).

get_balance :-
    current_output(Stream),
    tell(Stream, CurrentBalance),
    nl(Stream),
    told.

set_balance(NewBalance) :-
    retractall(balance(_)),
    assertz(balance(NewBalance)).
