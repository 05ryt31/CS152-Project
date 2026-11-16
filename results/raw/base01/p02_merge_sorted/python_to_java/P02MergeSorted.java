package results.raw.base01.p02_merge_sorted.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class P02MergeSorted {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            List<Integer> a = parseLine(reader.readLine());
            List<Integer> b = parseLine(reader.readLine());
            List<Integer> merged = mergeLists(a, b);
            if (!merged.isEmpty()) {
                System.out.println(String.join(" ", merged.stream().map(String::valueOf).toArray(String[]::new)));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static List<Integer> parseLine(String line) {
        List<Integer> values = new ArrayList<>();
        if (line != null && !line.trim().isEmpty()) {
            String[] tokens = line.split("\\s+");
            for (String token : tokens) {
                values.add(Integer.parseInt(token));
            }
        }
        return values;
    }

    private static List<Integer> mergeLists(List<Integer> a, List<Integer> b) {
        List<Integer> merged = new ArrayList<>();
        int i = 0, j = 0;
        while (i < a.size() && j < b.size()) {
            if (a.get(i) <= b.get(j)) {
                merged.add(a.get(i));
                i++;
            } else {
                merged.add(b.get(j));
                j++;
            }
        }
        while (i < a.size()) {
            merged.add(a.get(i));
            i++;
        }
        while (j < b.size()) {
            merged.add(b.get(j));
            j++;
        }
        return merged;
    }
}
