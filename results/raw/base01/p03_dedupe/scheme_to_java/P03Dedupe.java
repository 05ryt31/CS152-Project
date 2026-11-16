package results.raw.base01.p03_dedupe.scheme_to_java;

import java.util.*;

public class P03Dedupe {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        List<Integer> numbers = numbers(line);
        List<Integer> deduped = dedupe(numbers, new ArrayList<>());
        printList(deduped);
        System.exit(0);
    }

    private static List<Integer> numbers(String line) {
        if (line.isEmpty()) {
            return Collections.emptyList();
        }
        String[] parts = line.split(" ");
        List<Integer> result = new ArrayList<>();
        for (String part : parts) {
            result.add(Integer.parseInt(part));
        }
        return result;
    }

    private static List<Integer> dedupe(List<Integer> values, List<Integer> seen) {
        if (values.isEmpty()) {
            return Collections.emptyList();
        }
        int value = values.get(0);
        if (seen.contains(value)) {
            return dedupe(values.subList(1, values.size()), seen);
        } else {
            seen.add(value);
            List<Integer> rest = dedupe(values.subList(1, values.size()), seen);
            rest.add(0, value);
            return rest;
        }
    }

    private static void printList(List<Integer> values) {
        if (!values.isEmpty()) {
            System.out.print(values.get(0));
            for (int i = 1; i < values.size(); i++) {
                System.out.print(" " + values.get(i));
            }
            System.out.println();
        }
    }
}
