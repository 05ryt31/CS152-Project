bank :-
	bank(0).
 
bank(Balance) :-
	read_line_to_string(user_input, Line),
	atom_chars(Line, Chars),
	extract_command(Chars, Command, Rest),
	handle_command(Command, Balance, NewBalance, Rest),
	bank(NewBalance).
 
extract_command([32|_], [], []).
extract_command([], [], []).
extract_command([X|T], [X|R], Rest) :-
	extract_command(T, R, Rest).
extract_command([X|T], C, [X|R]) :-
	extract_command(T, C, R).
 
handle_command(['b', 'a', 'l', 'a', 'n', 'c', 'e'], _, Balance, []) :-
	format('Your balance is ~w~n', [Balance]).
handle_command(['d', 'e', 'p', 'o', 's', 'i', 't'], Balance, NewBalance, Rest) :-
	read_line_to_string(user_input, Amount),
	string_number(Amount, Number),
	NewBalance is Balance + Number,
	handle_rest(Rest).
handle_command(['w', 'i', 'd', 'r', 'w', 'a', 'l', 'l'], Balance, NewBalance, Rest) :-
	read_line_to_string(user_input, Amount),
	string_number(Amount, Number),
	(   Number > Balance ->
		format('Insufficient funds~n')
	;   NewBalance is Balance - Number,
	    handle_rest(Rest)).
handle_command(_, _, _, []).
 
handle_rest([]).
handle_rest(_).
