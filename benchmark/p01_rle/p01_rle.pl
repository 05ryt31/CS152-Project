:- initialization(p01_rle, main).

p01_rle :- 
    read_line_to_string(user_input, Line),
    string_chars(Line, Chars),
    encode(Chars, Out),
    format(user_output, '~s~n', [Out]),
    flush_output(user_output),
    halt.

encode([], []).
encode([C|Cs], Out) :- 
    run(C, Cs, Rest, 1, Count), 
    number_chars(Count, Ns), 
    encode(Rest, Tail), 
    append([[C|Ns], Tail], Out).

run(C, [C|Cs], Rest, N, Count) :- 
    N1 is N + 1, 
    run(C, Cs, Rest, N1, Count).
run(_, Rest, Rest, Count, Count).
