 
:- initialization(main, main).
 
main :-
	read_line_to_string(user_input, Line),
	atom_codes(Line, Codes),
	split_string(Codes, "\n", "", [Code]),
	stack_vm(Code).
 
stack_vm([_]) :- !.
stack_vm([Op|T]) :-
	handle_op(Op, T).
 
handle_op("push" , Rest) :-
	get_number(Rest, Number, Rest1),
	stack_vm(Number, Rest1).
handle_op("pop" , Rest) :-
	stack_vm([], Rest).
handle_op("add" , Rest) :-
	stack_vm(plus, Rest).
handle_op("mul" , Rest) :-
	stack_vm(times, Rest).
handle_op("dup" , Rest) :-
	stack_vm(dup, Rest).
handle_op("swap", Rest) :-
	stack_vm(swap, Rest).
handle_op(_, _).
 
stack_vm(Number, Rest) :-
	get_number(Rest, Number, Rest1),
	stack_vm(Rest1).
 
stack_vm([], []).
stack_vm(Operator, Rest) :-
	call(Operator, Stack, Rest, NewStack, Rest1),
	stack_vm(NewStack, Rest1).
 
get_number([Number | Rest], Number, Rest) :-
	number(Number).
 
call(plus, [A,B | Stack], Rest, [C | Stack], Rest) :-
	C is A + B.
 
call(times, [A,B | Stack], Rest, [C | Stack], Rest) :-
	C is A * B.
 
call(dup, [A | Stack], Rest, [A,A | Stack], Rest).
 
call(swap, [A,B | Stack], Rest, [B,A | Stack], Rest).
 
