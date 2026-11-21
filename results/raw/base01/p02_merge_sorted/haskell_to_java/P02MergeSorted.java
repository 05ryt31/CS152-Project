package results.raw.base01.p02_merge_sorted.haskell_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class P02MergeSorted {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            List<Integer> a = Arrays.stream(reader.readLine().split(" "))
                                     .map(Integer::parseInt)
                                     .collect(Collectors.toList());
            List<Integer> b = Arrays.stream(reader.readLine().split(" "))
                                     .map(Integer::parseInt)
                                     .collect(Collectors.toList());
            List<Integer> result = merge(a, b);
            if (!result.isEmpty()) {
                System.out.println(result.stream()
                                          .map(String::valueOf)
                                          .collect(Collectors.joining(" ")));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static List<Integer> merge(List<Integer> xs, List<Integer> ys) {
        if (xs.isEmpty()) return ys;
        if (ys.isEmpty()) return xs;
        if (xs.get(0) <= ys.get(0)) {
            return Stream.concat(Stream.of(xs.get(0)), merge(xs.subList(1, xs.size()), ys))
                         .collect(Collectors.toList());
        } else {
            return Stream.concat(Stream.of(ys.get(0)), merge(xs, ys.subList(1, ys.size())))
                         .collect(Collectors.toList());
        }
    }
}
