:- use_module(library(lists)).
:- use_module(library(readutil)).

p09_stack_vm :-
    read_lines(InputLines),
    process_lines(InputLines, [], Output),
    print_output(Output),
    halt.

read_lines([]) :-
    at_end_of_stream(current_input), !.
read_lines([H|T]) :-
    read_line_to_string(current_input, H),
    read_lines(T).

process_lines([], _, []).
process_lines([Line|Rest], Stack, Output) :-
    parse_line(Line, Op, Args),
    execute_op(Op, Args, Stack, NewStack),
    process_lines(Rest, NewStack, NewOutput),
    append(NewOutput, [OpResult], Output).

parse_line(Line, Op, Args) :-
    split_string(Line, " ", "", Parts),
    Op = Parts[0],
    Args = Parts[1:].

execute_op('push', [Arg], Stack, [NewTop|Stack]) :-
    NewTop is Arg.
execute_op('pop', [], Stack, NewStack) :-
    length(Stack, Len),
    Len > 0,
    pop(Stack, NewStack).
execute_op('pop', [], _Stack, ['error']).
execute_op('add', [], Stack, [NewTop|Stack]) :-
    length(Stack, Len),
    Len >= 2,
    pop(Stack, [B, A|Rest]),
    NewTop is A + B.
execute_op('add', [], _Stack, ['error']).
execute_op('mul', [], Stack, [NewTop|Stack]) :-
    length(Stack, Len),
    Len >= 2,
    pop(Stack, [B, A|Rest]),
    NewTop is A * B.
execute_op('mul', [], _Stack, ['error']).
execute_op('dup', [], Stack, [Top|NewStack]) :-
    length(Stack, Len),
    Len > 0,
    Top = Stack[-1],
    NewStack = [Top|Stack].
execute_op('dup', [], _Stack, ['error']).
execute_op('swap', [], Stack, [Top1, Top2|NewStack]) :-
    length(Stack, Len),
    Len >= 2,
    Top1 = Stack[-1],
    Top2 = Stack[-2],
    NewStack = [Top2, Top1|Stack].
execute_op('swap', [], _Stack, ['error']).
execute_op(_, [], _Stack, ['error']) :-
    true.

pop([_], []) :- !.
pop([_|Tail], Tail) :- !.

print_output(['error'|_]) :-
    format('error~n'), !.
print_output([H|T]) :-
    format('~w~n', [H]),
    print_output(T).
print_output([]) :-
    true.
