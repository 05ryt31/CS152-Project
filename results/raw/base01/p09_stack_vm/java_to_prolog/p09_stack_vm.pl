:- use_module(library(lists)).
:- use_module(library(readutil)).

p09_stack_vm :-
    read_line_to_string(current_input, N),
    number_codes(N, Number),
    length(Stack, Number),
    process_commands(Stack, []),
    halt.

process_commands([], _).
process_commands([Command | Rest], Stack) :-
    handle_command(Command, Stack, NewStack),
    process_commands(Rest, NewStack).

handle_command(['push', Value], Stack, [Value | Stack]).
handle_command(['pop'], Stack, NewStack) :-
    (   Stack = [_ | Tail] -> NewStack = Tail
    ;   format('error~n'), nl, NewStack = Stack
    ).
handle_command(['add'], Stack, [Result | NewStack]) :-
    (   Stack = [B, A | Tail] ->
        Result is A + B,
        NewStack = [Result | Tail]
    ;   format('error~n'), nl, NewStack = Stack
    ).
handle_command(['mul'], Stack, [Result | NewStack]) :-
    (   Stack = [B, A | Tail] ->
        Result is A * B,
        NewStack = [Result | Tail]
    ;   format('error~n'), nl, NewStack = Stack
    ).
handle_command(['dup'], Stack, [Top, Top | NewStack]) :-
    (   Stack = [Top | Tail] -> NewStack = Tail
    ;   format('error~n'), nl, NewStack = Stack
    ).
handle_command(['swap'], Stack, [Second, First, Second, First | NewStack]) :-
    (   Stack = [First, Second | Tail] -> NewStack = Tail
    ;   format('error~n'), nl, NewStack = Stack
    ).
handle_command(['print'], Stack, Stack) :-
    (   Stack = [Top | _] -> format('~d~n', [Top])
    ;   format('error~n'), nl
    ).

number_codes(Number, Codes) :-
    atom_number(Number, Codes).
