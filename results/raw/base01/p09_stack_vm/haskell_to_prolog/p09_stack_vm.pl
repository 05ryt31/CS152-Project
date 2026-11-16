:- use_module(library(lists)).
:- use_module(library(readutil)).

step([], "pop", [], "error").
step([_ | T], "pop", T, "").
step(Stack, "add", NewStack, "") :-
    length(Stack, Len),
    Len >= 2,
    [X, Y | Rest] = Stack,
    NewStack is X + Y,
    append(Rest, [NewStack], NewStackList),
    !.
step(Stack, "add", Stack, "error").

step(Stack, "mul", NewStack, "") :-
    length(Stack, Len),
    Len >= 2,
    [X, Y | Rest] = Stack,
    NewStack is X * Y,
    append(Rest, [NewStack], NewStackList),
    !.
step(Stack, "mul", Stack, "error").

step([], "dup", [], "error").
step([X | T], "dup", [X, X | T], "").

step(Stack, "swap", NewStack, "") :-
    length(Stack, Len),
    Len >= 2,
    [X, Y | Rest] = Stack,
    append([Y, X], Rest, NewStackList),
    !.
step(Stack, "swap", Stack, "error").

step([], "print", [], "error").
step([X | T], "print", T, X).

step(Stack, Command, Stack, "error") :-
    atom(Command),
    \+ member(Command, ["pop", "add", "mul", "dup", "swap", "print"]).

runStack(Commands, Outputs) :-
    maplist(runCommand, Commands, RawOutputs),
    Outputs = [Output | _],
    string_concat(Output, "\n", FinalOutput),
    format("~s", [FinalOutput]).

runCommand(Command, Output) :-
    atom(Command),
    runStep([], Command, _, Output).

runStep(Stack, "push" : [X | _], NewStack, "") :-
    number(X),
    NewStack = [X | Stack].
runStep(Stack, Command, NewStack, Error) :-
    step(Stack, Command, NewStack, Error).

p09_stack_vm :-
    read_line_to_string(current_input, N),
    number(N),
    findall(Command, read_line_to_string(current_input, Command), Commands),
    runStack(Commands, []),
    halt(0).
