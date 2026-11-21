package results.raw.base01.p10_lru.haskell_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class P10Lru {
    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int cap = Integer.parseInt(reader.readLine());
        int n = Integer.parseInt(reader.readLine());
        String[] commands = new String[n];
        for (int i = 0; i < n; i++) {
            commands[i] = reader.readLine();
        }
        reader.close();

        StringBuilder output = new StringBuilder();
        for (String command : runLRU(cap, commands)) {
            output.append(command).append("\n");
        }

        System.out.print(output.toString());
    }

    private static String[] runLRU(int cap, String[] commands) {
        Map<Integer, Integer> values = new HashMap<>();
        int[] order = new int[cap];
        int orderIndex = 0;

        for (String line : commands) {
            String[] parts = line.split(" ");
            if ("get".equals(parts[0])) {
                int key = Integer.parseInt(parts[1]);
                if (values.containsKey(key)) {
                    touch(key, order, orderIndex);
                    outputValue(values.get(key));
                } else {
                    outputValue(-1);
                }
            } else if ("put".equals(parts[0])) {
                int key = Integer.parseInt(parts[1]);
                int value = Integer.parseInt(parts[2]);
                if (!values.containsKey(key) && order.length == cap) {
                    removeOldest(order, orderIndex, values);
                }
                values.put(key, value);
                touch(key, order, orderIndex);
            }
        }

        return outputToStringArray();
    }

    private static void touch(int key, int[] order, int orderIndex) {
        for (int i = 0; i <= orderIndex; i++) {
            if (order[i] == key) {
                for (int j = i; j < orderIndex; j++) {
                    order[j] = order[j + 1];
                }
                break;
            }
        }
        order[orderIndex++] = key;
    }

    private static void removeOldest(int[] order, int orderIndex, Map<Integer, Integer> values) {
        int oldestKey = order[0];
        values.remove(oldestKey);
        for (int i = 0; i < orderIndex - 1; i++) {
            order[i] = order[i + 1];
        }
    }

    private static void outputValue(int value) {
        System.out.println(value);
    }

    private static String[] outputToStringArray() {
        // This is a placeholder since we don't have a way to capture System.out in Java without using a ByteArrayOutputStream
        // For the purpose of this example, we assume the output is already captured elsewhere.
        return new String[0];
    }
}
