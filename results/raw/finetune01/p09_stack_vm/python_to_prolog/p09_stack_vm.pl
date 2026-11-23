 
:- use_module(library(clpfd)).
 
% Stack VM
stack_vm :-
	stack_vm([push(5), push(3), add, mul, dup, swap, pop, print]).
 
stack_vm(Instr) :-
	empty_stack(Stack),
	stack_vm(Instr, [], Stack).
 
stack_vm([], _, _) :- !.
 
stack_vm([instr(I)|T], S, Stack) :-
	execute(I, S, Stack1),
	stack_vm(T, [I|S], Stack1).
 
stack_vm([_I|T], S, Stack) :-
	stack_vm(T, S, Stack).
 
execute(push(V), S, Stack) :-
	append(S, [V], S1),
	append(Stack, [V], Stack1).
 
execute(pop, S, Stack) :-
	length(S, 1),
	append(_, [V], S),
	append(Stack, [V], Stack1).
 
execute(print, S, Stack) :-
	length(S, 1),
	append(_, [V], S),
	write(V),
	append(Stack, [V], Stack1).
 
execute(add, S, Stack) :-
	length(S, 2),
	append(_, [A,B], S),
	A #= B + C,
	append(S, [C], S1),
	append(Stack, [C], Stack1).
 
execute(mul, S, Stack) :-
	length(S, 2),
	append(_, [A,B], S),
	A #= B * C,
	append(S, [C], S1),
	append(Stack, [C], Stack1).
 
execute(dup, S, Stack) :-
	length(S, 1),
	append(_, [A], S),
	append(S, [A,A], S1),
	append(Stack, [A,A], Stack1).
 
execute(swap, S, Stack) :-
	length(S, 2),
	append(_, [A,B], S),
	append(S, [B,A], S1),
	append(Stack, [B,A], Stack1).
 
empty_stack([]).
 
