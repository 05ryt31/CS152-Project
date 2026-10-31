package benchmark.p10_lru;

import java.io.*;
import java.util.*;

public class P10Lru {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int capacity = Integer.parseInt(reader.readLine());
        int n = Integer.parseInt(reader.readLine());
        LinkedHashMap<Integer, Integer> cache = new LinkedHashMap<>(capacity, 0.75f, true) {
            protected boolean removeEldestEntry(Map.Entry<Integer, Integer> entry) { return size() > capacity; }
        };

        for (int i = 0; i < n; i++) {
            String[] parts = reader.readLine().split("\\s+");
            int key = Integer.parseInt(parts[1]);
            if (parts[0].equals("get")) System.out.println(cache.getOrDefault(key, -1));
            else cache.put(key, Integer.parseInt(parts[2]));
        }
    }
}
