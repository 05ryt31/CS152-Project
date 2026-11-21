:- use_module(library(lists)).
:- use_module(library(readutil)).

matching('(', ')') :- !.
matching('[', ']') :- !.
matching('{', '}') :- !.
matching(_, _) :- fail.

valid([], []) :- !.
valid([C|CS], Stack) :-
    member(C, ['(','[','{']), !,
    valid(CS, [C|Stack]).
valid([C|CS], Stack) :-
    length(Stack, 0), !, fail.
valid([C|CS], [H|T]) :-
    matching(H, C), !,
    valid(CS, T).
valid(_,_).

p07_brackets :-
    read_line_to_string(current_input, N),
    string_to_number(N, NumLines),
    findall(Line, (between(1, NumLines, _), read_line_to_string(current_input, Line)), Lines),
    maplist(process_line, Lines),
    halt.

process_line(Line) :-
    valid(Line, []),
    format("yes~n").
process_line(_) :-
    format("no~n").
