:- initialization(p06_calc, main).

p06_calc :- 
    read_line_to_string(user_input, Line), 
    read_term_from_atom(Line, Expression, []), 
    Value is Expression, 
    writeln(Value),
    halt.
