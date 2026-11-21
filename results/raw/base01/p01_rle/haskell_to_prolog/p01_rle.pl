:- use_module(library(lists)).
:- use_module(library(readutil)).

p01_rle :-
    read_line_to_string(current_input, Line),
    process_line(Line),
    halt.

process_line([]) :- !.
process_line(Line) :-
    group(Line, Groups),
    format_groups(Groups),
    nl,
    !.

format_groups([]).
format_groups([Group|Rest]) :-
    [First|_] = Group,
    Length = length(Group),
    format('~c~d', [First, Length]),
    format_groups(Rest).

:- initialization(p01_rle).
