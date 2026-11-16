package results.raw.base01.p11_pipeline.scheme_to_java;

import java.util.*;
import java.io.*;

public class P11Pipeline {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<Integer> values = numbers(scanner.nextLine());
        int k = Integer.parseInt(scanner.nextLine());
        pipeline(k, values);
    }

    private static List<Integer> numbers(String line) {
        if (line.isEmpty()) return Collections.emptyList();
        String[] parts = line.split(" ");
        List<Integer> result = new ArrayList<>();
        for (String part : parts) {
            result.add(Integer.parseInt(part));
        }
        return result;
    }

    private static int sum(List<Integer> values) {
        return values.stream().reduce(0, Integer::sum);
    }

    private static int maximum(List<Integer> values) {
        return values.stream().max(Integer::compare).orElseThrow(NoSuchElementException::new);
    }

    private static List<Integer> keep(Predicate<Integer> predicate, List<Integer> values) {
        return values.stream().filter(predicate).collect(Collectors.toList());
    }

    private static List<Integer> applyStage(List<Integer> values, String[] parts) {
        String kind = parts[0];
        String name = parts[1];
        switch (kind) {
            case "map":
                int amount = Integer.parseInt(parts[2]);
                if ("add".equals(name)) {
                    return values.stream().map(x -> x + amount).collect(Collectors.toList());
                } else {
                    return values.stream().map(x -> x * amount).collect(Collectors.toList());
                }
            case "filter":
                switch (name) {
                    case "even":
                        return keep(Predicates::isEven, values);
                    case "odd":
                        return keep(Predicates::isOdd, values);
                    default:
                        int threshold = Integer.parseInt(parts[2]);
                        return keep(x -> x > threshold, values);
                }
            case "sum":
                return Collections.singletonList(sum(values));
            default:
                return values.isEmpty() ? Collections.singletonList(-1) : Collections.singletonList(maximum(values));
        }
    }

    private static void pipeline(int k, List<Integer> values) {
        for (int i = 0; i < k; i++) {
            String[] parts = readLine().split(" ");
            values = applyStage(values, parts);
        }
        if (!values.isEmpty()) {
            System.out.print(values.get(0));
            for (int j = 1; j < values.size(); j++) {
                System.out.print(" " + values.get(j));
            }
            System.out.println();
        } else {
            System.out.println(-1);
        }
    }

    private static String readLine() {
        try {
            return new BufferedReader(new InputStreamReader(System.in)).readLine();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static class Predicates {
        public static boolean isEven(int x) {
            return x % 2 == 0;
        }

        public static boolean isOdd(int x) {
            return x % 2 != 0;
        }
    }
}
