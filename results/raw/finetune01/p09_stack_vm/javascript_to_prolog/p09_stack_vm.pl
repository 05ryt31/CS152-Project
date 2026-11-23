 
:- use_module(library(clpfd)).
 
% Stack VM
%
%   push X S -> S1
%       where S1 = [X|S]
%
%   pop S -> (X,S1)
%       where S = [X|S1] and X is an integer
%
%   add S -> S1
%       where S = [A,B|S1] and A,B are integers
%       and S1 = [B+A|S1]
%
%   mul S -> S1
%       where S = [A,B|S1] and A,B are integers
%       and S1 = [B*A|S1]
%
%   dup S -> S1
%       where S = [A|S1] and A is an integer
%       and S1 = [A,A|S1]
%
%   swap S -> S1
%       where S = [A,B|S1] and A,B are integers
%       and S1 = [B,A|S1]
%
%   out S -> (X,S1)
%       where S = [X|S1] and X is an integer
%
%   err S -> error
%
 
% Pushes an integer onto the stack
push(X, S, S1) :-
	S1 = [X | S].
 
% Pops an integer off the stack
pop(S, X, S1) :-
	length(S, L),
	L #> 0,
	append(_,[X],S),
	\+ append(_,[X],S1).
 
% Adds the top two elements of the stack together
add(S, S1) :-
	length(S, L),
	L #> 1,
	append(_,[A,B|_],S),
	A #= B+C,
	append(_,[C],S1).
 
% Multiplies the top two elements of the stack together
mul(S, S1) :-
	length(S, L),
	L #> 1,
	append(_,[A,B|_],S),
	A #* B #= C,
	append(_,[C],S1).
 
% Duplicates the top element of the stack
dup(S, S1) :-
	length(S, L),
	L #> 0,
	append(_,[A|_],S),
	append(_,[A,A],S1).
 
% Swaps the top two elements of the stack
swap(S, S1) :-
	length(S, L),
	L #> 1,
	append(_,[A,B|_],S),
	append(_,[B,A],S1).
 
% Outputs the top element of the stack
out(S, X, S1) :-
	pop(S, X, S1).
 
% Errors when there is no top element of the stack
err(S) :-
	length(S, L),
	L #< 1.
 
% Runs a list of instructions on a stack
run([], _, []).
run([push(X)|T], S, S1) :-
	run(T, S, S2),
	push(X, S2, S1).
run([pop|T], S, S1) :-
	pop(S, _, S2),
	run(T, S2, S1).
run([add|T], S, S1) :-
	add(S, S2),
	run(T, S2, S1).
run([mul|T], S, S1) :-
	mul(S, S2),
	run(T, S2, S1).
run([dup|T], S, S1) :-
	dup(S, S2),
	run(T, S2, S1).
run([swap|T], S, S1) :-
	swap(S, S2),
	run(T, S2, S1).
run([out|T], S, S1) :-
	out(S, X, S2),
	writef('%w ',[X]),
	run(T, S2, S1).
run([err|T], S, S1) :-
	err(S),
	run(T, S, S1).
 
% Tests
test :-
	run([push(5),push(3),add],[],R1),
	writeln(R1),
	run([push(5),push(3),mul],[],R2),
	writeln(R2),
	run([push(5),push(3),dup],[],R3),
	writeln(R3),
	run([push(5),push(3),swap],[],R4),
	writeln(R4),
	run([push(5),push(3),out],[],R5),
	writeln(R5),
	run([push(5),push(3),err],[],R6),
	writeln(R6).
 
