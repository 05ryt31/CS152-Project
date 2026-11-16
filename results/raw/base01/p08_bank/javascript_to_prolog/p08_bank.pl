:- use_module(library(readutil)).
:- use_module(library(lists)).

p08_bank :-
    read_lines(InputLines),
    process_commands(InputLines, Output),
    print_output(Output),
    halt.

read_lines([]) :-
    at_end_of_stream(current_input), !.
read_lines([Line | Lines]) :-
    read_line_to_string(current_input, Line),
    read_lines(Lines).

process_commands([], []).
process_commands([Command | Commands], Output) :-
    process_command(Command, Output1),
    process_commands(Commands, Output2),
    append(Output1, Output2, Output).

process_command(['deposit', AmountStr], ['ok' | Rest]) :-
    number(Amount, AmountStr),
    NewBalance is CurrentBalance + Amount,
    process_command(['balance'], ['NewBalance' | Rest]).
process_command(['withdraw', AmountStr], ['error' | Rest]) :-
    number(Amount, AmountStr),
    CurrentBalance >= Amount,
    NewBalance is CurrentBalance - Amount,
    process_command(['balance'], ['NewBalance' | Rest]).
process_command(['balance'], [CurrentBalance | _]) :-
    get_balance(CurrentBalance).

get_balance(Balance) :-
    retractall(balance(_)),
    assertz(balance(Balance)),
    balance(Balance).

print_output([]).
print_output([Output | Outputs]) :-
    format('~w~n', [Output]),
    print_output(Outputs).
