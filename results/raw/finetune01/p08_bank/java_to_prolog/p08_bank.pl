bank :-
	bank(0).
 
bank(Balance) :-
	read_line_to_string(user_input, Line),
	atom_chars(Line, Chars),
	extract_command(Chars, Command, Params),
	process_command(Command, Params, Balance).
 
process_command(bal, _, Balance) :-
	writef('Balance: %w\n', [Balance]).
 
process_command(deposit, [Amount], Balance) :-
	New_balance is Amount + Balance,
	bank(New_balance).
 
process_command(withdraw, [Amount], Balance) :-
	(Amount > Balance ->
		writeln('Error')
	;
		New_balance is Balance - Amount,
		bank(New_balance)).
 
extract_command([32|_], bal, []).
extract_command([45, 32|_], withdraw, _).
extract_command([100, 97, 116, 116, 111, 32|T], deposit, [A]) :-
	number_chars(A, T).
 
