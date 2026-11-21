package results.raw.base01.p02_merge_sorted.scheme_to_java;

import java.util.*;

public class P02MergeSorted {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<Integer> list1 = numbers(scanner.nextLine());
        List<Integer> list2 = numbers(scanner.nextLine());
        printList(merge(list1, list2));
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

    private static List<Integer> merge(List<Integer> a, List<Integer> b) {
        if (a.isEmpty()) {
            return b;
        } else if (b.isEmpty()) {
            return a;
        } else if (a.get(0) <= b.get(0)) {
            List<Integer> merged = new ArrayList<>(a);
            merged.addAll(merge(a.subList(1, a.size()), b));
            return merged;
        } else {
            List<Integer> merged = new ArrayList<>(b);
            merged.addAll(merge(a, b.subList(1, b.size())));
            return merged;
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
