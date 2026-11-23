import java.util.*;
 
class LRUCache {
    private final int capacity;
    private final LinkedHashMap<Integer, Integer> cache =
            new LinkedHashMap<>(capacity, 0.75f, true) {
                @Override
                protected boolean removeEldestEntry(Map.Entry eldest) {
                    return size() > capacity;
                }
            };
 
    public LRUCache(int capacity) {
        this.capacity = capacity;
    }
 
    public int get(int key) {
        return cache.getOrDefault(key, -1);
    }
 
    public void set(int key, int value) {
        cache.put(key, value);
    }
}
 
public class LRU {
    public static void main(String[] args) {
        LRUCache cache = new LRUCache(2 /* capacity */);
 
        cache.set(1, 1);
        cache.set(2, 2);
        System.out.println(cache.get(1));       // returns 1
        cache.set(3, 3);    // evicts key 2
        System.out.println(cache.get(2));       // returns -1 (not found)
        cache.set(4, 4);    // evicts key 1
        System.out.println(cache.get(1));       // returns -1 (not found)
        System.out.println(cache.get(3));       // returns 3
        System.out.println(cache.get(4));       // returns 4
    }
}
