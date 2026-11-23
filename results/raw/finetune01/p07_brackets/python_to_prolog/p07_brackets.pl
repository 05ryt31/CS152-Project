balanced('()').
balanced('[()]{}').
balanced('{{{{}}}}').
 
unbalanced('([]').


check_balanced :-
	balanced(String),
	format('Balanced string ~w~n', [String]),
	unbalanced(String),
	format('Unbalanced string ~w~n', [String]).
 
