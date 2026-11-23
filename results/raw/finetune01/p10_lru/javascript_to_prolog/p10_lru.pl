:- use_module(library(clpfd)).
 
lru_cache(Capacity, Cache, Cache) :-
	length(Cache, Capacity).
 
lru_cache(Capacity, Cache, New_Cache) :-
	length(Cache, Len),
	Len < Capacity,
	append(Cache, [Key-Value], New_Cache).
 
lru_cache(Capacity, Cache, New_Cache) :-
	length(Cache, Len),
	Len > Capacity,
	select(Key-_, Cache, Rest),
	lru_cache(Capacity, Rest, New_Cache).
 
cache_get(Key, Cache, Value) :-
	member(Key-Value, Cache).
 
cache_get(_, [], -1).
 
cache_get(Key, Cache, Value) :-
	select(Key-Value, Cache, Rest),
	cache_get(Key, Rest, Value).
 
cache_put(Key, Value, Cache, Cache) :-
	member(Key-_, Cache).
 
cache_put(Key, Value, Cache, [Key-Value | Cache]) :-
	\+ member(Key-_, Cache).
 
cache_put(Key, Value, Cache, New_Cache) :-
	select(Key-_, Cache, Rest),
	cache_put(Key, Value, Rest, New_Cache).
 
test :-
	Capacity = 3,
	New_Cache = [],
	Key = 1,
	Value = 10,
	lru_cache(Capacity, New_Cache, Cache1),
	cache_put(Key, Value, Cache1, Cache2),
	cache_get(Key, Cache2, Value1),
	format('Cache ~w~n', [Cache2]),
	format('Get ~w -> ~w~n', [Key, Value1]).
 
