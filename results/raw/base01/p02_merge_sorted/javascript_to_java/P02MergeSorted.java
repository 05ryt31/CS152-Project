package results.raw.base01.p02_merge_sorted.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class P02MergeSorted {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            List<Integer> a = parseLine(reader.readLine());
            List<Integer> b = parseLine(reader.readLine());
            List<Integer> result = mergeLists(a, b);
            if (!result.isEmpty()) {
                System.out.println(result.stream().mapToInt(i -> i).toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static List<Integer> parseLine(String line) {
        String[] parts = line.trim().split("\\s+");
        List<Integer> list = new ArrayList<>();
        for (String part : parts) {
            list.add(Integer.parseInt(part));
        }
        return list;
    }

    private static List<Integer> mergeLists(List<Integer> a, List<Integer> b) {
        List<Integer> result = new ArrayList<>();
        int i = 0, j = 0;
        while (i < a.size() && j < b.size()) {
            if (a.get(i) <= b.get(j)) {
                result.add(a.get(i));
                i++;
            } else {
                result.add(b.get(j));
                j++;
            }
        }
        while (i < a.size()) {
            result.add(a.get(i));
            i++;
        }
        while (j < b.size()) {
            result.add(b.get(j));
            j++;
        }
        return result;
    }
}
