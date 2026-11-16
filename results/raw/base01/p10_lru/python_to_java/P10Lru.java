package results.raw.base01.p10_lru.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

public class P10Lru {
    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int capacity = Integer.parseInt(reader.readLine());
        int n = Integer.parseInt(reader.readLine());
        Map<Integer, Integer> values = new LinkedHashMap<>();
        for (int i = 0; i < n; i++) {
            String[] parts = reader.readLine().split();
            int key = Integer.parseInt(parts[1]);
            if ("get".equals(parts[0])) {
                if (values.containsKey(key)) {
                    values.put(key, values.get(key)); // Reinsert to update position
                    System.out.println(values.get(key));
                } else {
                    System.out.println(-1);
                }
            } else {
                if (values.containsKey(key)) {
                    values.remove(key);
                } else if (values.size() == capacity) {
                    int oldestKey = values.keySet().iterator().next();
                    values.remove(oldestKey);
                }
                values.put(key, Integer.parseInt(parts[2]));
            }
        }
    }
}
