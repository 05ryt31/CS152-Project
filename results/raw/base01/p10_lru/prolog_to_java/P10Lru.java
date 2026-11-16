package results.raw.base01.p10_lru.prolog_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class P10Lru {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new BufferedReader(new InputStreamReader(System.in)))) {
            int C = Integer.parseInt(scanner.nextLine());
            int N = Integer.parseInt(scanner.nextLine());
            List<String> cache = new ArrayList<>();
            while (N-- > 0) {
                String[] parts = scanner.nextLine().split(" ");
                if ("get".equals(parts[0])) {
                    get(Integer.parseInt(parts[1]), cache);
                } else if ("put".equals(parts[0])) {
                    put(Integer.parseInt(parts[1]), Integer.parseInt(parts[2]), C, cache);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void get(int key, List<String> cache) {
        for (int i = 0; i < cache.size(); i++) {
            String[] entry = cache.get(i).split("-");
            if (Integer.parseInt(entry[0]) == key) {
                System.out.println(entry[1]);
                cache.remove(i);
                cache.add(0, cache.get(i));
                return;
            }
        }
        System.out.println(-1);
    }

    private static void put(int key, int value, int capacity, List<String> cache) {
        for (int i = 0; i < cache.size(); i++) {
            String[] entry = cache.get(i).split("-");
            if (Integer.parseInt(entry[0]) == key) {
                cache.set(i, key + "-" + value);
                return;
            }
        }
        if (cache.size() >= capacity) {
            cache.remove(cache.size() - 1);
        }
        cache.add(0, key + "-" + value);
    }
}
