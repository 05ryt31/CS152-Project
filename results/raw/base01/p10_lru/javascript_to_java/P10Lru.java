package results.raw.base01.p10_lru.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

public class P10Lru {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String[] lines = reader.lines().toArray(String[]::new);
            int capacity = Integer.parseInt(lines[0]);
            int n = Integer.parseInt(lines[1]);

            Map<Integer, Integer> values = new HashMap<>();
            StringBuilder output = new StringBuilder();

            for (int i = 0; i < n; i++) {
                String[] parts = lines[i + 2].split("\\s+");
                int key = Integer.parseInt(parts[1]);
                if ("get".equals(parts[0])) {
                    if (values.containsKey(key)) {
                        output.append(values.get(key)).append("\n");
                        touch(key, values);
                    } else {
                        output.append("-1\n");
                    }
                } else {
                    if (values.containsKey(key)) {
                        touch(key, values);
                    } else if (values.size() == capacity) {
                        values.remove(values.keySet().iterator().next());
                    }
                    values.put(key, Integer.parseInt(parts[2]));
                }
            }

            System.out.print(output.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void touch(int key, Map<Integer, Integer> values) {
        values.remove(key);
        values.put(key, values.get(key));
    }
}
