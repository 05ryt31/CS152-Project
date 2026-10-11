smoke_io :- 
    read_line_to_string(current_input, Text),
    write('Hello, '), 
    write(Text),
    nl.
