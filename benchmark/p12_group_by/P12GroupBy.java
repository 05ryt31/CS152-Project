package benchmark.p12_group_by;

import java.io.*;
import java.util.*;

public class P12GroupBy {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int n = Integer.parseInt(reader.readLine());

        Map<String, int[]> groups = new TreeMap<>();
        for (int i = 0; i < n; i++) {
            String[] parts = reader.readLine().split("\\s+");
            int[] values = groups.computeIfAbsent(parts[0], key -> new int[2]);
            values[0] += Integer.parseInt(parts[1]); 
            values[1]++;
        }

        for (Map.Entry<String, int[]> entry : groups.entrySet()) System.out.println(entry.getKey() + " " + entry.getValue()[0] + " " + entry.getValue()[1]);
    }
}
