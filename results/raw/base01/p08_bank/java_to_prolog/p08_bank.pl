:- use_module(library(readutil)).
:- use_module(library(lists)).

p08_bank :-
    read_line_to_string(current_input, N),
    number_codes(N, Number),
    process_transactions(Number).

process_transactions(0) :- !.
process_transactions(N) :-
    read_line_to_string(current_input, Line),
    split_string(Line, " ", "", Parts),
    handle_transaction(Parts),
    M is N - 1,
    process_transactions(M).

handle_transaction(["deposit", Amount]) :-
    number_codes(Amount, Num),
    add_balance(Num).
handle_transaction(["withdraw", Amount]) :-
    number_codes(Amount, Num),
    withdraw_balance(Num).
handle_transaction(["balance"]) :-
    get_balance.

add_balance(Amount) :-
    current_output(Stream),
    tell(Stream, Amount),
    nl(Stream),
    told.

withdraw_balance(Amount) :-
    get_balance(Balance),
    NewBalance is Balance - Amount,
    (NewBalance >= 0 ->
        set_balance(NewBalance),
        current_output(Stream),
        tell(Stream, NewBalance),
        nl(Stream),
        told ;
        format('error~n')
    ).

get_balance :-
    current_output(Stream),
    tell(Stream, 'error'),
    nl(Stream),
    told.

set_balance(NewBalance) :-
    retractall(balance(_)),
    assertz(balance(NewBalance)).

initially :-
    assertz(balance(0)).

:- initialization(initially).
:- initialization(p08_bank).
:- halt.
