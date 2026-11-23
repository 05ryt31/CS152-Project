from collections import OrderedDict
 
class LRUCache(OrderedDict):
    def __init__(self, capacity):
        self.capacity = capacity
 
    def get(self, key):
        if key in self:
            self.move_to_end(key)
        return super().get(key, -1)
 
    def put(self, key, value):
        if key in self:
            self.move_to_end(key)
        super().__setitem__(key, value)
        if len(self) > self.capacity:
            self.popitem(last=False)
 
cache = LRUCache(2)
cache['a'] = 1
cache['b'] = 2
print(cache.get('a')) # prints 1
cache['c'] = 3
print(cache.get('b')) # prints -1
