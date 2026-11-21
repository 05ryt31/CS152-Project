package results.raw.base01.p12_group_by.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

public class P12GroupBy {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            int n = Integer.parseInt(reader.readLine());
            Map<String, Integer> sums = new HashMap<>();
            Map<String, Integer> counts = new TreeMap<>();

            for (int i = 0; i < n; i++) {
                String[] parts = reader.readLine().split();
                String key = parts[0];
                int value = Integer.parseInt(parts[1]);

                sums.putIfAbsent(key, 0);
                counts.putIfAbsent(key, 0);

                sums.put(key, sums.get(key) + value);
                counts.put(key, counts.get(key) + 1);
            }

            for (String key : sums.keySet()) {
                System.out.println(key + " " + sums.get(key) + " " + counts.get(key));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
