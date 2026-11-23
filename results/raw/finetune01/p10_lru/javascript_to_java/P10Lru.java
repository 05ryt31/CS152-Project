import java.util.*;
 
class LRUCache<K,V> extends LinkedHashMap<K,V> {
    private final int maxSize;
 
    public LRUCache(int maxSize) {
        super(maxSize, 0.75f, true);
        this.maxSize = maxSize;
    }
 
    @Override
    protected boolean removeEldestEntry(Map.Entry eldest) {
        return size() > maxSize;
    }
}
 
public class LRU {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int cacheSize = Integer.parseInt(in.nextLine());
        int queries = Integer.parseInt(in.nextLine());
        LRUCache<Integer,Integer> cache = new LRUCache<>(cacheSize);
        while (queries-- > 0) {
            String[] query = in.nextLine().split(" ");
            switch(query[0]) {
                case "get":
                    System.out.println(cache.getOrDefault(Integer.parseInt(query[1]), -1));
                    break;
                case "set":
                    cache.put(Integer.parseInt(query[1]), Integer.parseInt(query[2]));
                    break;
            }
        }
    }
}
