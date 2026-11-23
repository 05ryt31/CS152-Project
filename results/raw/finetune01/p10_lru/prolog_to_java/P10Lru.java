import java.util.*;
 
class LRUCache {
    private final int capacity;
    private final Map<Integer, Integer> cache;
    private final LinkedList<Integer> queue;
 
    public LRUCache(int capacity) {
        this.capacity = capacity;
        this.cache = new HashMap<>(capacity);
        this.queue = new LinkedList<>();
    }
 
    public int get(int key) {
        if (!cache.containsKey(key)) return -1;
        updateQueue(key);
        return cache.get(key);
    }
 
    public void put(int key, int value) {
        if (cache.containsKey(key)) {
            cache.put(key, value);
            updateQueue(key);
            return;
        }
        if (cache.size() == capacity) {
            int lru = queue.removeLast();
            cache.remove(lru);
        }
        cache.put(key, value);
        queue.addFirst(key);
    }
 
    private void updateQueue(int key) {
        queue.remove((Integer)key);
        queue.addFirst(key);
    }
}
