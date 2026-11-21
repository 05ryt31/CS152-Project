package results.raw.base01.p12_group_by.prolog_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class P12GroupBy {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String nLine = reader.readLine();
            int n = Integer.parseInt(nLine);
            Map<String, int[]> groups = new HashMap<>();
            for (int i = 0; i < n; i++) {
                String line = reader.readLine();
                String[] parts = line.split(" ");
                String key = parts[0];
                int value = Integer.parseInt(parts[1]);
                groups.merge(key, new int[]{value, 1}, (a, b) -> new int[]{a[0] + b[0], a[1] + 1});
            }
            List<Map.Entry<String, int[]>> sortedEntries = new ArrayList<>(groups.entrySet());
            Collections.sort(sortedEntries, Comparator.comparing(Map.Entry::getKey));
            for (Map.Entry<String, int[]> entry : sortedEntries) {
                System.out.printf("%s %d %d%n", entry.getKey(), entry.getValue()[0], entry.getValue()[1]);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
