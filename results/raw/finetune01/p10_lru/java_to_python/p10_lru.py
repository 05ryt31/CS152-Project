from collections import OrderedDict
 
class LRUCache(OrderedDict):
    'Limited-size LRU cache'
    def __init__(self, *args, **kwds):
        self.update(kwds)
        self.size_limit = kwds.pop('size', None)
    def __getitem__(self, key):
        item = OrderedDict.__getitem__(self, key)
        self.move_to_end(key)
        return item
    def __setitem__(self, key, value):
        OrderedDict.__setitem__(self, key, value)
        if self.size_limit is not None:
            while len(self) > self.size_limit:
                self.popitem(last=False)
 
if __name__ == '__main__':
    cache = LRUCache(size=3)
    cache['a'] = 1
    cache['b'] = 2
    cache['c'] = 3
    print(list(cache.keys()))
    cache['d'] = 4
    print(list(cache.keys()))
    cache['a']
    print(list(cache.keys()))
