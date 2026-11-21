package results.raw.base01.p10_lru.scheme_to_java;

import java.util.*;
import java.io.*;

public class P10Lru {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int capacity = Integer.parseInt(scanner.nextLine());
        int n = Integer.parseInt(scanner.nextLine());

        Map<Integer, Integer> entries = new HashMap<>();
        List<Integer> order = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            String[] parts = scanner.nextLine().split(" ");
            String op = parts[0];
            int key = Integer.parseInt(parts[1]);

            if ("get".equals(op)) {
                Integer value = entries.get(key);
                if (value != null) {
                    System.out.print(value + " ");
                    touch(key, order);
                } else {
                    System.out.print(-1 + " ");
                }
            } else {
                int value = Integer.parseInt(parts[2]);
                entries.put(key, value);
                touch(key, order);

                if (!entries.containsKey(key) && order.size() == capacity + 1) {
                    int oldest = order.remove(0);
                    entries.remove(oldest);
                }
            }
        }

        System.exit(0);
    }

    private static void touch(int key, List<Integer> order) {
        order.remove(Integer.valueOf(key));
        order.add(key);
    }
}
