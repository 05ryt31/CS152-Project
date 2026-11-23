function LRUCache(capacity) {
    this.capacity = capacity;
    this.cache = {};
    this.keys = [];
}
 
LRUCache.prototype.get = function(key) {
    if (this.cache.hasOwnProperty(key)) {
        var idx = this.keys.indexOf(key);
        this.keys.splice(idx, 1);
        this.keys.push(key);
        return this.cache[key];
    } else {
        return -1;
    }
};
 
LRUCache.prototype.set = function(key, value) {
    if (this.cache.hasOwnProperty(key)) {
        this.cache[key] = value;
        var idx = this.keys.indexOf(key);
        this.keys.splice(idx, 1);
        this.keys.push(key);
    } else {
        if (this.keys.length === this.capacity) {
            var k = this.keys.shift();
            delete this.cache[k];
        }
        this.cache[key] = value;
        this.keys.push(key);
    }
};
 
var cache = new LRUCache(2);
cache.set(1, 1);
cache.set(2, 2);
print(cache.get(1));       // returns 1
cache.set(3, 3);    // evicts key 2
print(cache.get(2));       // returns -1 (not found)
cache.set(4, 4);    // evicts key 1
print(cache.get(1));       // returns -1 (not found)
print(cache.get(3));       // returns 3
print(cache.get(4));       // returns 4
