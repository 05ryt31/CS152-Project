:- use_module(library(clpfd)).
 
lru_cache(Capacity, Cache, Key, Value, New_Cache) :-
	length(Cache, Length),
	Length < Capacity,
	!,
	append(Cache, [(Key,Value)]).
 
lru_cache(Capacity, Cache, Key, Value, New_Cache) :-
	length(Cache, Length),
	Length >= Capacity,
	!,
	select((Old_Key, Old_Value), Cache, Rest),
	dif(Key, Old_Key),
	lru_cache(Capacity, Rest, Key, Value, New_Cache).
 
lru_cache(_, Cache, _, _, Cache).
 
cache_get([(Key, Value)|_], Key, Value).
cache_get([_|T], Key, Value) :-
	cache_get(T, Key, Value).
 
cache_get(Cache, Key, -1) :-
	member((Key,_), Cache),
	!.
cache_get(Cache, Key, Value) :-
	member((Key,Value), Cache).
 
cache_put(Cache, Key, Value, New_Cache) :-
	select((Key,_), Cache, Rest),
	append(Rest, [(Key,Value)], New_Cache).
 
cache_put(Cache, Key, Value, Cache) :-
	member((Key,_), Cache),
	!.
cache_put(Cache, Key, Value, [(Key,Value)|Cache]).
 
test :-
	Capacity = 3,
	lru_cache(Capacity, [], put, 1, 100, Cache1),
	writef('put 1 -> 100: %w\n', [Cache1]),
	cache_get(Cache1, 1, V1),
	writef('get 1: %w\n', [V1]),
	lru_cache(Capacity, Cache1, put, 2, 200, Cache2),
	writef('put 2 -> 200: %w\n', [Cache2]),
	cache_get(Cache2, 2, V2),
	writef('get 2: %w\n', [V2]),
	lru_cache(Capacity, Cache2, put, 3, 300, Cache3),
	writef('put 3 -> 300: %w\n', [Cache3]),
	cache_get(Cache3, 3, V3),
	writef('get 3: %w\n', [V3]),
	lru_cache(Capacity, Cache3, put, 4, 400, Cache4),
	writef('put 4 -> 400: %w\n', [Cache4]),
	cache_get(Cache4, 4, V4),
	writef('get 4: %w\n', [V4]),
	cache_get(Cache4, 1, V5),
	writef('get 1: %w\n', [V5]).
 
