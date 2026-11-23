:- use_module(library(clpfd)).
 
% lru_cache(Capacity, Cache, Input, Output, New_Cache).
%
% Capacity is the maximum number of items in cache.
% Cache is the current state of the cache.
% Input is a list of pairs [Key, Value].
% Output is a list of values corresponding to keys in Input.
% New_Cache is the updated state of the cache.
lru_cache(Capacity, Cache, [], [], Cache):- !.
lru_cache(Capacity, Cache, [[Key,Value]|Rest], [Value|Output], New_Cache):-
	member([Key,_,_], Cache),
	(   select([Key,_,_], Cache, Temp), % remove item from cache
	    Cache = [Temp|Cache],
	    Cache = [Key,Value,New_Cache],
	    lru_cache(Capacity, Cache, Rest, Output, _).
lru_cache(Capacity, Cache, [[Key,Value]|Rest], [Value|Output], New_Cache):-
	select([_,_,_], Cache, Temp), % remove least recently used item from cache
	Capacity #> 0,
	length(Temp, Length),
	Length #> 0,
	Index #= 1 + random(Length),
	nth0(Index, Temp, [_,_,LRU]),
	select([_,_,LRU], Temp, Cache),
	Cache = [Key,Value,New_Cache],
	lru_cache(Capacity, Cache, Rest, Output, _).
lru_cache(Capacity, Cache, [_|Rest], Output, New_Cache):-
	Capacity #> 0,
	lru_cache(Capacity, Cache, Rest, Output, New_Cache).
 
