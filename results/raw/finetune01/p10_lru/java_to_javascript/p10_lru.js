function LRUCache(capacity) {
    this.capacity = capacity;
    this.cache = {};
    this.keys = [];
}
 
LRUCache.prototype.set = function(key, value) {
    var keys = this.keys;
    if (this.cache.hasOwnProperty(key)) {
        // Move the key to the end, so it will be the most recently used.
        keys.splice(keys.indexOf(key), 1);
    } else if (keys.length === this.capacity) {
        // Remove the least recently used item.
        delete this.cache[keys.shift()];
    }
    // Add the new item.
    this.cache[key] = value;
    keys.push(key);
};
 
LRUCache.prototype.get = function(key) {
    var value = this.cache[key];
    if (value !== undefined) {
        // Move the key to the end, so it will be the most recently used.
        this.keys.splice(this.keys.indexOf(key), 1);
        this.keys.push(key);
    }
    return value;
};
 
var lru = new LRUCache(3);
lru.set('a', 1);
lru.set('b', 2);
lru.set('c', 3);
print(lru.get('a')); // 1
lru.set('d', 4);     // evicts 'b'
print(lru.get('b')); // null
print(lru.get('d')); // 4
lru.set('a', 5);     // evicts 'c'
print(lru.get('c')); // null
print(lru.get('a')); // 5
