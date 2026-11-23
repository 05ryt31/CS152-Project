from collections import OrderedDict
 
class LRUCache(OrderedDict):
    def __init__(self, capacity):
        self.capacity = capacity
 
    def get(self, key):
        if key not in self:
            return -1
        else:
            # Move the requested key to the end to show that it was recently used.
            self.move_to_end(key)
            return self[key]
 
    def put(self, key, value):
        if key in self:
            # Move the existing key to the end to show that it was recently used.
            self.move_to_end(key)
        self[key] = value
        if len(self) > self.capacity:
            # Pop the first key-value pair
            self.popitem(last=False)
 
cache = LRUCache(2)
cache.put(1, 1)
cache.put(2, 2)
print(cache.get(1))
cache.put(3, 3)
print(cache.get(2))
cache.put(4, 4)
print(cache.get(1))
print(cache.get(3))
print(cache.get(4))
