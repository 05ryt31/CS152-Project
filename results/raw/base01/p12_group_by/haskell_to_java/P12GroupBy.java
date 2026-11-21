package results.raw.base01.p12_group_by.haskell_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class P12GroupBy {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new BufferedReader(new InputStreamReader(System.in)))) {
            int n = Integer.parseInt(scanner.nextLine());
            Map<String, int[]> grouped = new HashMap<>();
            for (int i = 0; i < n; i++) {
                String[] parts = scanner.nextLine().split(" ");
                if (parts.length == 2) {
                    String key = parts[0];
                    int value = Integer.parseInt(parts[1]);
                    grouped.merge(key, new int[]{value, 1}, (a, b) -> new int[]{a[0] + b[0], a[1] + b[1]});
                }
            }

            for (Map.Entry<String, int[]> entry : grouped.entrySet()) {
                System.out.println(entry.getKey() + " " + entry.getValue()[0] + " " + entry.getValue()[1]);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
