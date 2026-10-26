package benchmark.p02_merge_sorted;

import java.io.*;
import java.util.*;

public class P02MergeSorted {
    static int[] parse(String line) {
        if (line == null || line.isEmpty()) return new int[0];

        String[] parts = line.trim().split("\\s+");
        int[] values = new int[parts.length];

        for (int i = 0; i < parts.length; i++) values[i] = Integer.parseInt(parts[i]);

        return values;
    }

    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int[] a = parse(reader.readLine());
        int[] b = parse(reader.readLine());
        StringBuilder result = new StringBuilder();
        int i = 0;
        int j = 0;

        while (i < a.length && j < b.length) {
            if (result.length() > 0) result.append(' ');

            if (a[i] <= b[j]) {
                result.append(a[i]);
                i++;
            } else {
                result.append(b[j]);
                j++;
            }
        }

        while (i < a.length) {
            if (result.length() > 0) result.append(' ');
            result.append(a[i]);
            i++;
        }

        while (j < b.length) {
            if (result.length() > 0) result.append(' ');
            result.append(b[j]);
            j++;
        }

        if (result.length() > 0) System.out.println(result);
    }
}
