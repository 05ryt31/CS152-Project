:- use_module(library(readutil)).

p09_stack_vm :-
    read_line_to_string(current_input, N),
    number_codes(N, Number),
    length(Stack, Number),
    process_commands(Stack, []),
    format('~n'),
    halt.

process_commands([], _) :- !.
process_commands([Op | Rest], Stack) :-
    handle_command(Op, Stack, NewStack),
    process_commands(Rest, NewStack).

handle_command(['push', Value], Stack, [Value | Stack]) :-
    number_codes(Value, Number),
    !.
handle_command(['pop'], Stack, [_ | NewStack]) :-
    length(NewStack, Length),
    Length > 0,
    !.
handle_command(['add'], Stack, [Result | NewStack]) :-
    length(NewStack, Length),
    Length >= 2,
    pop_two(NewStack, A, B),
    Result is A + B,
    !.
handle_command(['mul'], Stack, [Result | NewStack]) :-
    length(NewStack, Length),
    Length >= 2,
    pop_two(NewStack, A, B),
    Result is A * B,
    !.
handle_command(['dup'], Stack, [Top, Top | Stack]) :-
    length(Stack, Length),
    Length >= 1,
    !.
handle_command(['swap'], Stack, [Second, First, Second, First | Stack]) :-
    length(Stack, Length),
    Length >= 2,
    !.
handle_command(['print'], Stack, Stack) :-
    length(Stack, Length),
    Length >= 1,
    pop_top(Stack, Top),
    format('~d~n', [Top]),
    !.

pop_two([A, B | Rest], A, B) :-
    !.
pop_top([Top | Rest], Top) :-
    !.
