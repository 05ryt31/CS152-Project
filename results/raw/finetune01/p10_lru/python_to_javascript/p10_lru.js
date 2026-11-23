function LRUCache(capacity) {
    this.capacity = capacity;
    this.cache = {};
    this.order = [];
}
 
LRUCache.prototype.get = function(key) {
    var value = this.cache[key];
    if (value !== undefined) {
        this.order.splice(this.order.indexOf(key), 1);
        this.order.push(key);
        return value;
    }
    return -1;
};
 
LRUCache.prototype.set = function(key, value) {
    if (this.cache.hasOwnProperty(key)) {
        delete this.cache[key];
        this.order.splice(this.order.indexOf(key), 1);
    } else if (this.order.length === this.capacity) {
        var lruKey = this.order.shift();
        delete this.cache[lruKey];
    }
    this.cache[key] = value;
    this.order.push(key);
};
 
var cache = new LRUCache(3);
cache.set(1, 1);
cache.set(2, 2);
cache.set(3, 3);
print(cache.get(1));
cache.set(4, 4);
print(cache.get(2));
