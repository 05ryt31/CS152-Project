import java.util.*;
 
class LRUCache {
    private final int capacity;
    private final Map<Integer, Integer> cache = new HashMap<>();
    private final LinkedList<Integer> queue = new LinkedList<>();
 
    public LRUCache(int capacity) {
        this.capacity = capacity;
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
        if (queue.size() == capacity) {
            cache.remove(queue.poll());
        }
        cache.put(key, value);
        queue.offer(key);
    }
 
    private void updateQueue(Integer key) {
        queue.remove(key);
        queue.offer(key);
    }
}
