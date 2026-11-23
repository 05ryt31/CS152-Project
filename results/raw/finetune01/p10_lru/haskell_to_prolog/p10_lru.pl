lru_cache(Capacity, Cache, Commands, Result):-
	lru_cache(Capacity, Cache, Commands, [], Result).
 
lru_cache(_, _, [], Cache, Cache):-!.
 
lru_cache(Capacity, Cache, [[get, Key]|T], Acc, Result):-
	(   get_value(Cache, Key, Value)
	->  NewCache = Cache,
	    Order = [Key|Acc],
	    lru_cache(Capacity, NewCache, T, Order, Result)
	;   NewCache = Cache,
	    Order = Acc,
	    lru_cache(Capacity, NewCache, T, Order, Result)).
 
lru_cache(Capacity, Cache, [[put, Key, Value]|T], Acc, Result):-
	get_value(Cache, Key, _),
	delete_key(Cache, Key, NewCache),
	lru_cache(Capacity, NewCache, T, [Key|Acc], Result).
 
lru_cache(Capacity, Cache, [[put, Key, Value]|T], Acc, Result):-
	length(Acc, Length),
	Length < Capacity,
	put_value(Cache, Key, Value, NewCache),
	lru_cache(Capacity, NewCache, T, [Key|Acc], Result).
 
lru_cache(Capacity, Cache, [[put, Key, Value]|T], Acc, Result):-
	length(Acc, Length),
	Length >= Capacity,
	take_last(Acc, Last),
	delete_key(Cache, Last, NewCache),
	put_value(NewCache, Key, Value, FinalCache),
	lru_cache(Capacity, FinalCache, T, [Key|Acc], Result).
 
take_last([_], []):-!.
 
take_last([_|T], R):-take_last(T, R).
 
delete_key(Map, Key, Map):-
	Map \= Map.find(Key, _).
 
delete_key(Map, Key, NewMap):-
	Map.find(Key, _),
	Map.erase(Key),
	Map = NewMap.
 
get_value(Map, Key, Value):-
	Map.find(Key, Value).
 
put_value(Map, Key, Value, Map):-
	Map.put(Key, Value).
 
