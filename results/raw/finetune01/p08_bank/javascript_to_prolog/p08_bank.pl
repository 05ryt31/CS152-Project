bank :-
	bank([balance(0)]).
 
bank(Balance) :-
	read_line_to_string(user_input, Line),
	atom_chars(Line, Chars),
	atomic_list_concat(Words, ' ', Chars),
	process_command(Words, Balance).
 
process_command(['exit'], _Balance) :- !.
process_command(['balance'], Balance) :-
	get_balance(Balance, Amount),
	format('Your current balance is ~w~n', [Amount]).
process_command(['deposit', Amount], Balance) :-
	string_number(Amount, Value),
	update_balance(deposit(Value), Balance, NewBalance),
	bank(NewBalance).
process_command(['withdraw', Amount], Balance) :-
	string_number(Amount, Value),
	update_balance(withdraw(Value), Balance, NewBalance),
	bank(NewBalance).
process_command(_, _Balance) :-
	write('Invalid command'), nl.
 
get_balance(balanced(Amount), Amount).
 
update_balance(Command, Balance, NewBalance) :-
	Command =:= deposit(Amount),
	get_balance(Balance, Current),
	NewAmount is Current + Amount,
	set_balance(Balance, NewAmount, NewBalance).
 
update_balance(Command, Balance, Balance) :-
	Command =:= withdraw(Amount),
	get_balance(Balance, Current),
	Current < Amount,
	write('Insufficient funds available'), nl.
 
update_balance(Command, Balance, NewBalance) :-
	Command =:= withdraw(Amount),
	get_balance(Balance, Current),
	NewAmount is Current - Amount,
	set_balance(Balance, NewAmount, NewBalance).
 
set_balance(balanced(_), Amount, balanced(Amount)).
 
