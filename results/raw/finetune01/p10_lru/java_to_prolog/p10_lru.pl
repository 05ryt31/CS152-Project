:- use_module(library(clpfd)).
 
lru_cache(Capacity, Cache, Cache) :-
	length(Cache, Capacity).
 
lru_cache(Capacity, Cache, New_Cache) :-
	length(Cache, Len),
	Len < Capacity,
	append(Cache, [Key], New_Cache).
 
lru_cache(Capacity, Cache, New_Cache) :-
	length(Cache, Len),
	Len > Capacity,
	sort(1, @>=, Cache, Sorted),
	taille(Sorted, Tail),
	append(Tail, [Key], New_Cache).
 
taille([], []).
taille([_H|T], T).
 
cache_get(Key, Cache, Value) :-
	member((Key, Value), Cache).
 
cache_get(_, [], -1).
 
cache_put(Key, Value, Cache, New_Cache) :-
	cache_get(Key, Cache, _),
	retract((Cache -> Key, Value)),
	lru_cache(10, Cache, New_Cache).
 
cache_put(Key, Value, Cache, [(Key, Value)|Cache]).
 
main :-
	read_file_to_string('input.txt', File, []),
	string_to_list(File, Lst),
	split_string(Lst, "\n", "\n", Lines),
	maplist(split_string("\s+", " \s+", White_space), Lines, Tokens),
	maplist(parse_command, Tokens, Commands),
	aggregate(max(V), lru_cache(10, _, V), Max),
	Max #= 10,
	label(Max),
	run_commands(Commands, Max, Cache, Cache),
	write_cache(Cache).
 
parse_command(['put'|Rest], Command) :-
	[Key, Value] = Rest,
	integer(Value),
	Command = put(Key, Value).
 
parse_command(['get'|Rest], Command) :-
	[Key] = Rest,
	integer(Key),
	Command = get(Key).
 
run_commands([], _, Cache, Cache).
 
run_commands([Command|Commands], Max, Cache, Final_Cache) :-
	execute_command(Command, Max, Cache, New_Cache),
	run_commands(Commands, Max, New_Cache, Final_Cache).
 
execute_command(get(Key), Max, Cache, Cache) :-
	cache_get(Key, Cache, Value),
	format('key ~w has value ~w~n', [Key, Value]).
 
execute_command(put(Key, Value), Max, Cache, New_Cache) :-
	cache_put(Key, Value, Cache, New_Cache),
	lru_cache(Max, New_Cache, _).
 
write_cache([]).
 
write_cache([(Key, Value)|Cache]) :-
	format('key ~w has value ~w~n', [Key, Value]),
	write_cache(Cache).
 
