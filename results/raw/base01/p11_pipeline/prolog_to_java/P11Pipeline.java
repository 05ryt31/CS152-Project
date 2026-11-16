package results.raw.base01.p11_pipeline.prolog_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

public class P11Pipeline {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new BufferedReader(new InputStreamReader(System.in)))) {
            List<String> parts = Arrays.asList(scanner.nextLine().split(" "));
            List<Integer> values = parts.stream()
                    .skip(1)
                    .map(Integer::parseInt)
                    .toList();
            int k = Integer.parseInt(scanner.nextLine());
            List<Object> result = stages(k, values);
            output(result);
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            System.exit(1);
        }
    }

    private static List<Object> stages(int k, List<Integer> values) {
        if (k == 0) return values;
        List<String> parts = Arrays.asList(scanner.nextLine().split(" "));
        List<Integer> newValues = applyStage(parts, values);
        return stages(k - 1, newValues);
    }

    private static List<Integer> applyStage(List<String> parts, List<Integer> values) {
        String operation = parts.get(0);
        String type = parts.get(1);
        int n = parts.size() > 2 ? Integer.parseInt(parts.get(2)) : 0;
        switch (operation + "_" + type) {
            case "map_add":
                return values.stream().map(x -> x + n).toList();
            case "map_mul":
                return values.stream().map(x -> x * n).toList();
            case "filter_even":
                return values.stream().filter(x -> x % 2 == 0).toList();
            case "filter_odd":
                return values.stream().filter(x -> x % 2 != 0).toList();
            case "filter_gt":
                return values.stream().filter(x -> x > n).toList();
            case "reduce_sum":
                return List.of(values.stream().mapToInt(Integer::intValue).sum());
            default:
                throw new IllegalArgumentException("Unknown operation: " + operation + "_" + type);
        }
    }

    private static void output(Object result) {
        if (result instanceof List<?> list && !list.isEmpty()) {
            System.out.println(list.stream().map(Object::toString).collect(Collectors.joining(" ")));
        } else if (result instanceof Integer integer) {
            System.out.println(integer);
        } else if (result instanceof String string) {
            System.out.println(string);
        } else {
            System.out.println("none");
        }
    }
}
