:- use_module(library(readutil)).
:- use_module(library(lists)).

p06_calc :-
    read_line_to_string(current_input, Line),
    string_codes(Line, Codes),
    split_string(Codes, '', ['\n'], Tokens),
    maplist(string_to_number, Tokens, Numbers),
    calculate_expression(Numbers, Result),
    format('~d~n', [Result]),
    halt.

string_to_number(String, Number) :-
    atom_number(String, Number).

calculate_expression([], 0).
calculate_expression([Number], Number).
calculate_expression([Left, '*', Right | Rest], Result) :-
    NewLeft is Left * Right,
    calculate_expression([NewLeft | Rest], Result).
calculate_expression([Left, '+', Right | Rest], Result) :-
    NewLeft is Left + Right,
    calculate_expression([NewLeft | Rest], Result).
calculate_expression([Left, '-', Right | Rest], Result) :-
    NewLeft is Left - Right,
    calculate_expression([NewLeft | Rest], Result).
