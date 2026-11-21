:- use_module(library(lists)).
:- use_module(library(readutil)).

p09_stack_vm :-
    read_line_to_string(current_input, Input),
    N is string_to_number(Input),
    stack_vm(N),
    halt.

stack_vm(N) :-
    stack_vm(N, []).

stack_vm(0, Stack) :-
    print_stack(Stack).

stack_vm(N, Stack) :-
    read_line_to_string(current_input, Line),
    process_command(Line, Stack, NewStack),
    M is N - 1,
    stack_vm(M, NewStack).

process_command(Command, Stack, NewStack) :-
    atom_codes(Command, Codes),
    phrase(parse_command(Codes), Tokens),
    handle_command(Tokens, Stack, NewStack).

parse_command([], []).
parse_command([H|T], [H|T]) :-
    H \= ' '.

handle_command(['push', Value], Stack, NewStack) :-
    Number is string_to_number(Value),
    NewStack = [Number | Stack].
handle_command(['pop'], Stack, NewStack) :-
    Stack = [_ | Rest],
    NewStack = Rest.
handle_command(['add'], Stack, NewStack) :-
    length(Stack, Len),
    Len >= 2,
    pop_two(Stack, A, B, Rest),
    NewStack = [(A + B) | Rest].
handle_command(['mul'], Stack, NewStack) :-
    length(Stack, Len),
    Len >= 2,
    pop_two(Stack, A, B, Rest),
    NewStack = [(A * B) | Rest].
handle_command(['dup'], Stack, NewStack) :-
    length(Stack, Len),
    Len > 0,
    pop_one(Stack, Top, Rest),
    NewStack = [Top, Top | Rest].
handle_command(['swap'], Stack, NewStack) :-
    length(Stack, Len),
    Len >= 2,
    pop_two(Stack, A, B, Rest),
    NewStack = [B, A | Rest].
handle_command(_, _, _) :-
    print('error').

pop_one([Top | Rest], Top, Rest).
pop_two([First, Second | Rest], First, Second, Rest).

print_stack([]).
print_stack([Top | Rest]) :-
    format('~d~n', [Top]),
    print_stack(Rest).
