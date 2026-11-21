package results.raw.base01.p12_group_by.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeSet;

public class P12GroupBy {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int n = Integer.parseInt(reader.readLine());
        
        Map<String, int[]> groups = new HashMap<>();
        for (int i = 0; i < n; i++) {
            String[] parts = reader.readLine().split("\\s+");
            String key = parts[0];
            int value = Integer.parseInt(parts[1]);
            groups.merge(key, new int[]{value, 1}, (a, b) -> new int[]{a[0] + b[0], a[1] + b[1]});
        }
        
        TreeSet<String> sortedKeys = new TreeSet<>(groups.keySet());
        for (String key : sortedKeys) {
            int[] group = groups.get(key);
            System.out.println(key + " " + group[0] + " " + group[1]);
        }
    }
}
