package results.raw.base01.p11_pipeline.haskell_to_java;

import java.util.*;
import java.io.*;

public class P11Pipeline {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<Integer> values = Arrays.stream(scanner.nextLine().split(" "))
                                     .map(Integer::parseInt)
                                     .collect(Collectors.toList());
        int k = Integer.parseInt(scanner.nextLine());
        List<String> stages = new ArrayList<>();
        for (int i = 0; i < k; i++) {
            stages.add(scanner.nextLine());
        }
        
        List<Integer> result = stages.stream()
                                      .reduce(values, (xs, stage) -> apply(xs, stage.split(" ")), 
                                              (a, b) -> a); // This should never happen
        
        if (result.isEmpty() && k > 0 && "reduce".equals(stages.get(k - 1).split(" ")[0])) {
            System.out.println("none");
        } else if (!result.isEmpty()) {
            System.out.println(result.stream().map(String::valueOf).collect(Collectors.joining(" ")));
        }
    }

    private static List<Integer> apply(List<Integer> xs, String[] stage) {
        switch (stage[0]) {
            case "map":
                if ("add".equals(stage[1])) {
                    return xs.stream().map(x -> x + Integer.parseInt(stage[2])).collect(Collectors.toList());
                } else if ("mul".equals(stage[1])) {
                    return xs.stream().map(x -> x * Integer.parseInt(stage[2])).collect(Collectors.toList());
                }
                break;
            case "filter":
                if ("even".equals(stage[1])) {
                    return xs.stream().filter(x -> x % 2 == 0).collect(Collectors.toList());
                } else if ("odd".equals(stage[1])) {
                    return xs.stream().filter(x -> x % 2 != 0).collect(Collectors.toList());
                } else if ("gt".equals(stage[1])) {
                    return xs.stream().filter(x -> x > Integer.parseInt(stage[2])).collect(Collectors.toList());
                }
                break;
            case "reduce":
                if ("sum".equals(stage[1])) {
                    return Collections.singletonList(xs.stream().mapToInt(Integer::intValue).sum());
                } else if ("max".equals(stage[1])) {
                    return xs.isEmpty() ? Collections.emptyList() : Collections.singletonList(Collections.max(xs));
                }
                break;
        }
        return xs;
    }
}
