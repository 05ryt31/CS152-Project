:- initialization(p09_stack_vm, main).

p09_stack_vm :- 
    read_line_to_string(user_input, NLine), 
    number_string(N, NLine), 
    run(N, [], _),
    halt.

run(0, Stack, Stack).
run(N, Stack, Result) :- 
    N > 0, 
    read_line_to_string(user_input, Line), 
    split_string(Line, " ", " ", Parts), 
    execute(Parts, Stack, NewStack), 
    N1 is N - 1, 
    run(N1, NewStack, Result).

execute(["push", X], S, [V|S]) :- number_string(V, X).

execute(["pop"], [], []) :- writeln(error).
execute(["pop"], [_|S], S).

execute([Op], S, S) :- 
    memberchk(Op, ["add", "mul"]), 
    length(S, N), 
    N < 2, 
    writeln(error).
execute(["add"], [B,A|S], [C|S]) :- C is A + B.
execute(["mul"], [B,A|S], [C|S]) :- C is A * B.

execute(["dup"], [], []) :- writeln(error).
execute(["dup"], [X|S], [X,X|S]).

execute(["swap"], [A,B|S], [B,A|S]).
execute(["swap"], S, S) :- length(S, N), N < 2, writeln(error).

execute(["print"], [], []) :- writeln(error).
execute(["print"], [X|S], [X|S]) :- writeln(X).
