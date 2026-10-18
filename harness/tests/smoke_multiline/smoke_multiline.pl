read_all_lines(Lines) :-
    read_line_to_string(current_input, Line),
    (   Line == end_of_file
    ->  Lines = []
    ;   Lines = [Line|Rest],
        read_all_lines(Rest)
    ).

smoke_multiline :-
    read_all_lines(Lines),
    reverse(Lines, Reversed),
    forall(member(Line, Reversed), (write(Line), nl)).
