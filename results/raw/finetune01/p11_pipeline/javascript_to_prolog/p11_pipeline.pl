pipeline :-
	Lines = ["3 4 5 6", "7 8 9 10"],
	% read the first line and split it into numbers
	read_numbers(Lines, Numbers),
 
	% apply the operations in order
	pipeline([Numbers], Lines, Result),
 
	% print the result
	print_result(Result).
 
pipeline(Accumulated, [], Accumulated):-!.
pipeline(Accumulated, [Line|Lines], FinalResult):-
	process_line(Line, Accumulated, NewAccumulated),
	pipeline(NewAccumulated, Lines, FinalResult).
 
process_line(Line, Accumulated, Result):-
	split_string(Line, "\s\t\n\r,", "", Tokens),
 
	% get the operation name
	operation_name(Tokens, OperationName),
 
	% get the arguments
	arguments(Tokens, Arguments),
 
	% execute the operation
	execute_operation(OperationName, Arguments, Accumulated, Result).
 
execute_operation(sum, _, [Sum], Sum):-!.
execute_operation(max, _, [Max], Max):-!.
execute_operation(min, _, [Min], Min):-!.
execute_operation(map, [Operation, Value], [NewValues], NewValues):-
	maplist(operation(Value, Operation), Accumulated, NewValues).
execute_operation(filter, [Condition, Value], [FilteredValues], FilteredValues):-
	filter_values(Condition, Value, Accumulated, FilteredValues).
 
operation_name([OpName|_], OpName).
arguments([_|Args], Args).
 
operation(add, Value, X, Y):-Y is X+Value.
operation(mul, Value, X, Y):-Y is X*Value.
 
filter_values(even, _, [X|Rest], [X|Filtered]):-
	X mod 2 =:= 0,
	filter_values(even, _, Rest, Filtered).
filter_values(even, _, [_|Rest], Filtered):-
	filter_values(even, _, Rest, Filtered).
 
filter_values(odd, _, [X|Rest], [X|Filtered]):-
	X mod 2 =\= 0,
	filter_values(odd, _, Rest, Filtered).
filter_values(odd, _, [_|Rest], Filtered):-
	filter_values(odd, _, Rest, Filtered).
 
filter_values(greater_than, Value, [X|Rest], [X|Filtered]):-
	X > Value,
	filter_values(greater_than, Value, Rest, Filtered).
filter_values(greater_than, Value, [_|Rest], Filtered):-
	filter_values(greater_than, Value, Rest, Filtered).
 
print_result([]):-!.
print_result([X]):-
	format('~w~n', [X]).
print_result([X|Xs]):-
	format('~w ', [X]),
	print_result(Xs).
 
read_numbers([Line|_], Numbers):-
	split_string(Line, "\s\t\n\r,", "", Tokens),
	maplist(atom_number, Tokens, Numbers).
