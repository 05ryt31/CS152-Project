:- initialization(p07_brackets, main).

p07_brackets :- 
    safe_read_line(NLine), 
    number_string(N, NLine), 
    run(N),
    halt.

safe_read_line(Result) :-
    read_line_to_string(user_input, Line), 
    (   Line == end_of_file
    ->  Result = ""
    ;   Result = Line
    ).

run(0).
run(N) :- 
    N > 0, 
    safe_read_line(Line), 
    (   balanced(Line) 
    ->  writeln(yes) 
    ;   writeln(no)
    ), 
    N1 is N - 1, 
    run(N1).

balanced(Line) :- 
    string_chars(Line, Chars), 
    balanced_chars(Chars, []).

balanced_chars([], []).
balanced_chars([C|Cs], Stack) :- 
    memberchk(C, ['(', '[', '{']), 
    balanced_chars(Cs, [C|Stack]).
balanced_chars([C|Cs], [Open|Stack]) :- 
    matching(Open, C), 
    balanced_chars(Cs, Stack).

matching('(', ')').
matching('[', ']').
matching('{', '}').
