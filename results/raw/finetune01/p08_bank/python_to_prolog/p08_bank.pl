bank :-
	bank(0).
 
bank(Balance) :-
	read_line_to_string(user_input, Line),
	atom_chars(Line, Chars),
	atomic_list_concat(Words, ' ', Chars),
	process_command(Words, Balance).
 
process_command(['deposit', Amount], Balance) :-
	atom_number(Amount, N),
	N >= 0,
	Balance1 is Balance + N,
	bank(Balance1).
 
process_command(['withdraw', Amount], Balance) :-
	atom_number(Amount, N),
	N >= 0,
	Balance >= N,
	Balance1 is Balance - N,
	bank(Balance1).
 
process_command(['withdraw', Amount], Balance) :-
	atom_number(Amount, N),
	N >= 0,
	format('Error~n'),
	bank(Balance).
 
process_command(['balance'], Balance) :-
	writef('%w\n', [Balance]).
 
process_command(_, _) :-
	format('Invalid command~n').
 
