```prolog
 
:- use_module(library(clpfd)).
 
% Stack VM
 
% Pushes an integer onto the stack
push(S, I, S1):-
	append(S, [I], S1).
 
% Pops an integer off the stack
pop(S, I, S1):-
	length(S, L),
	L > 0,
	append(_S, [I|S1], S),
	_ is L - 1.
 
% Adds top two integers on the stack
add(S, S1):-
	pop(S, I1, S2),
	pop(S2, I2, S3),
	I is I1 + I2,
	push(S3, I, S1).
 
% Multiplies top two integers on the stack
mul(S, S1):-
	pop(S, I1, S2),
	pop(S2, I2, S3),
	I is I1 * I2,
	push(S3, I, S1).
 
% Duplicates top integer on the stack
dup(S, S1):-
	pop(S, I, S2),
	push(S2, I, S3),
	push(S3, I, S1).
 
% Swaps top two integers on the stack
swap(S, S1):-
	pop(S, I1, S2),
	pop(S2, I2, S3),
	push(S3, I1, S4),
	push(S4, I2, S1).
 
% Prints top integer on the stack
print(S, I, S1):-
	pop(S, I, S1).
 
% Runs a list of instructions on a stack
run([], _, []):-!.
run([push(I)|T], S, S1):-
	push(S, I, S2),
	run(T, S2, S1).
run([pop(I)|T], S, S1):-
	pop(S, I, S2),
	run(T, S2, S1).
run([add|T], S, S1):-
	add(S, S2),
	run(T, S2, S1).
run([mul|T], S, S1):-
	mul(S, S2),
	run(T, S2, S1).
run([dup|T], S, S1):-
	dup(S, S2),
	run(T, S2, S1).
run([swap|T], S, S1):-
	swap(S, S2),
	run(T, S2, S1).
run([print(I)|T], S, S1):-
	print(S, I, S2),
	run(T, S2, S1).
 
% Tests
test1:-
	S = [],
	run([push(5), push(6), add], S, S1),
	writef('Test 1: %w\n', [S1]).
 
test2:-
	S = [],
	run([push(5), push(6), mul], S, S1),
	writef('Test 2: %w\n', [S1]).
 
test3:-
	S = [],
	run([push(5), dup], S, S1),
	writef('Test 3: %w\n', [S1]).
 
test4:-
	S = [],
	run([push(5), push(6), swap], S, S1),
	writef('Test 4: %w\n', [S1]).
 
test5:-
	S = [],
	run([push(5), print(5)], S, S1),
	writef('Test 5: %w\n', [S1]).
 
test6:-
	S = [],
	run([push(5), push(6), pop(7)], S, S1),
	writef('Test 6: %w\n', [S1]).
 
test7:-
	S = [],
	run([push(5), push(6), add, pop(7)], S, S1),
	writef('Test 7: %w\n', [S1]).
 
test8:-
	S = [],
	run([push(5), push(6), mul, pop(7)], S, S1),
	writef('Test 8: %w\n', [S1]).
 
test9:-
	S = [],
	run([push(5), push(6), dup, pop(7)], S, S1),
	writef('Test 9: %w\n', [S1]).
 
test10:-
	S = [],
	run([push(5), push(6), swap, pop(7)], S, S1),
	writef('Test 10: %w\n', [S1]).
 
test11:-
	S = [],
	run([push(5), push(6), print(5)], S, S1),
	writef('Test 11: %w\n', [S1]).
 
test12:-
	S = [],
	run([push(5), push(6), print(6)], S, S1),
	writef('Test 12: %w\n', [S1]).
 
test13:-
	S = [],
	run([push(5), push(6), print(7)], S, S1),
	writef('Test 13: %w\n', [S1]).
 
test14:-
	S = [],
	run([push(5), push(6), add, print(5)], S, S1),
	writef('Test 14: %w\n', [S1]).
 
test15:-
	S = [],
	run([push(5), push(6), mul, print(5)], S, S1),
	writef('Test 15: %w\n', [S1]).
 
test16:-
	S = [],
	run([push(5), push(6), dup, print(5)], S, S1),
	writef('Test 16: %w\n', [S1]).
 
test17:-
	S = [],
	run([push(5), push(6), swap, print(5)], S, S1),
	writef('Test 17: %w\n', [S1]).
 
test18:-
	S = [],
	run([push(5), push(6), add, pop(7), print(5)], S, S1),
	writef('Test 18: %w\n', [S1]).
 
test19:-
	S = [],
	run([push(5), push(6), mul, pop(7), print(5)], S, S1),
	writef('Test 19: %w\n', [S1]).
 
test20:-
	S = [],
	run([push(5), push(6), dup, pop(7), print(5)], S, S1),
	writef('Test 20: %w\n', [S1]).
 
test21:-
	S = [],
	run([push(5), push(6), swap, pop(7), print(5)], S, S1),
	writef('Test 21: %w\n', [S1]).
 
test22:-
	S = [],
	run([push(5), push(6), add, pop(7), print(6)], S, S1),
	writef('Test 22: %w\n', [S1]).
 
test23:-
	S = [],
	run([push(5), push(6), mul, pop(7), print(6)], S, S1),
	writef('Test 23: %w\n', [S1]).
 
test24:-
	S = [],
	run([push(5), push(6), dup, pop(7), print(6)], S, S1),
	writef('Test 24: %w\n', [S1]).
 
test25:-
	S = [],
	run([push(5), push(6), swap, pop(7), print(6)], S, S1),
	writef('Test 25: %w\n', [S1]).
 
test26:-
	S = [],
	run([push(5), push(6), add, pop(7), print(7)], S, S1),
	writef('Test 26: %w\n', [S1]).
 
test27:-
	S = [],
	run([push(5), push(6), mul, pop(7), print(7)], S, S1),
	writef('Test 27: %w\n', [S1]).
 
test28:-
	S = [],
	run([push(5), push(6), dup, pop(7), print(7)], S, S1),
	writef('Test 28: %w\n', [S1]).
 
test29:-
	S = [],
	run([push(5), push(6), swap, pop(7), print(7)], S, S1),
	writef('Test 29: %w\n', [S1]).
 
test30:-
	S = [],
	run([push(5), push(6), add, pop(7), print(8)], S, S1),
	writef('Test 30: %w\n', [S1]).
 
test31:-
	S = [],
	run([push(5), push(6), mul, pop(7), print(8)], S, S1),
	writef('Test 31: %w\n', [S1]).
 
test32:-
	S = [],
	run([push(5), push(6), dup, pop(7), print(8)], S, S1),
	writef('Test
