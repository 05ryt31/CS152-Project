:- initialization(p08_bank, main).

p08_bank :- 
    read_line_to_string(user_input, NLine), 
    number_string(N, NLine), 
    commands(N, 0),
    halt.

commands(0, _).
commands(N, Balance) :- 
    N > 0, 
    read_line_to_string(user_input, Line), 
    split_string(Line, " ", " ", Parts), 
    command(Parts, Balance, NewBalance), 
    N1 is N - 1, 
    commands(N1, NewBalance).

command(["deposit", Amount], Balance, New) :- 
    number_string(Value, Amount), 
    New is Balance + Value.
command(["withdraw", Amount], Balance, Balance) :- 
    number_string(Value, Amount), 
    Value > Balance, 
    writeln(error).
command(["withdraw", Amount], Balance, New) :- 
    number_string(Value, Amount), 
    Value =< Balance, New is Balance - Value.
command(["balance"], Balance, Balance) :- writeln(Balance).
