function LRUCache(capacity) {
    this.capacity = capacity;
    this.cache = {};
    this.order = [];
}
 
LRUCache.prototype.get = function(key) {
    if (this.cache.hasOwnProperty(key)) {
        var index = this.order.indexOf(key);
        this.order.splice(index, 1);
        this.order.push(key);
        return this.cache[key];
    } else {
        return -1;
    }
};
 
LRUCache.prototype.set = function(key, value) {
    if (this.cache.hasOwnProperty(key)) {
        this.cache[key] = value;
        var index = this.order.indexOf(key);
        this.order.splice(index, 1);
        this.order.push(key);
    } else {
        if (Object.keys(this.cache).length >= this.capacity) {
            delete this.cache[this.order.shift()];
        }
        this.cache[key] = value;
        this.order.push(key);
    }
};
 
var cache = new LRUCache(3);
cache.set("a", 1);
cache.set("b", 2);
cache.set("c", 3);
cache.set("d", 4);
cache.get("a");
cache.set("e", 5);
