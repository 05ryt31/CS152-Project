:- use_module(library(readutil)).
:- use_module(library(lists)).

p08_bank :-
    read_line_to_string(current_input, N),
    string_number(N, Num),
    findall(Command, read_command(Command), Commands),
    process_commands(Num, Commands, Output),
    format('~s~n', [Output]),
    halt.

read_command(Command) :-
    read_line_to_string(current_input, Line),
    atom_codes(Line, Codes),
    phrase(parse_command(Codes), Command).

parse_command([97, 100, 115, 116, 111, 112, 101|T], ['deposit'|Rest]) -->
    parse_int(T, Rest).
parse_command([119, 114, 97, 110, 119, 105, 114, 116, 101|T], ['withdraw'|Rest]) -->
    parse_int(T, Rest).
parse_command([98, 97, 114, 97, 116, 101|T], ['balance'|Rest]) -->
    !,
    {Rest = []}.
parse_command(_, []) --> !.

parse_int([], []).
parse_int([C|T], [N|NT]) :-
    digit_code(C, D),
    N is D * 10^Length,
    parse_int(T, NT).

digit_code(C, D) :-
    C >= 48, C =< 57,
    D is C - 48.

process_commands(0, _, '') :- !.
process_commands(N, [Command|Commands], Output) :-
    process_command(Command, State, NewState),
    process_commands(N-1, Commands, Rest),
    append(Output, NewState, NewOutput),
    process_commands(N-1, Commands, Rest),
    !.

process_command(['deposit'|[Amount]], Balance, '':-
    NewBalance is Balance + Amount,
    format('New balance: ~d~n', [NewBalance]),
    NewBalance.

process_command(['withdraw'|[Amount]], Balance, 'error' :-
    Amount > Balance,
    format('Insufficient funds~n').
process_command(['withdraw'|[Amount]], Balance, '' :-
    NewBalance is Balance - Amount,
    format('New balance: ~d~n', [NewBalance]),
    NewBalance.

process_command(['balance'], Balance, '' :-
    format('Current balance: ~d~n', [Balance]).
