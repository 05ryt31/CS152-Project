 
:- initialization(main).
 
main :-
	read_line_to_string(user_input, Line),
	string_to_list(Line, Lst),
	atom_chars(N, Lst),
	number_chars(M, N),
	bank(M).
 
bank(0) :- !.
bank(N) :-
	read_line_to_string(user_input, Line),
	process_command(Line),
	N1 is N - 1,
	bank(N1).
 
process_command(Line) :-
	string_to_list(Line, Lst),
	atom_chars(Command, Lst),
	atom_chars(Command, [C|_]),
	atom_chars(Command, [_|Args]),
	atom_chars(Args, ArgsLst),
	atom_chars(Args, ArgsLst),
	execute_command(C, Args).
 
execute_command('deposit', Args) :-
	atomic_list_concat([_, Amount], ' ', Args),
	number_chars(Amount, Number),
	deposit(Number).
 
execute_command('withdraw', Args) :-
	atomic_list_concat([_, Amount], ' ', Args),
	number_chars(Amount, Number),
	withdraw(Number).
 
execute_command(_, _) :-
	write('Invalid command').
 
deposit(Amount) :-
	get_balance(Balance),
	Balance1 is Balance + Amount,
	set_balance(Balance1).
 
withdraw(Amount) :-
	get_balance(Balance),
	Amount =< Balance,
	Balance1 is Balance - Amount,
	set_balance(Balance1).
withdraw(_) :-
	write('Insufficient funds').
 
get_balance(Balance) :-
	default_balances(Balances),
	member(balance(Balance), Balances).
 
set_balance(NewBalance) :-
	retract(default_balances(Balances)),
	include(\X^(X \= balance(_)), Balances, RestBalances),
	append(RestBalances, [balance(NewBalance)], NewBalances),
	assert(default_balances(NewBalances)).
 
default_balances([balance(0)]).
 
