import java.util.Arrays;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;
 
public class Pipeline {
 
    public static void main(String[] args) {
        List<Integer> values = Arrays.asList(1, 2, 3, 4, 5);
        System.out.println("Initial values: " + values);
 
        Function<List<Integer>, List<Integer>> adder = list -> {
            int n = Integer.parseInt(readLine("Enter a number to add: "));
            return list.stream().map(i -> i + n).collect(Collectors.toList());
        };
 
        Function<List<Integer>, List<Integer>> multiplier = list -> {
            int n = Integer.parseInt(readLine("Enter a number to multiply by: "));
            return list.stream().map(i -> i * n).collect(Collectors.toList());
        };
 
        Function<List<Integer>, List<Integer>> filterEven = list -> list.stream()
                .filter(i -> i % 2 == 0)
                .collect(Collectors.toList());
 
        Function<List<Integer>, List<Integer>> filterOdd = list -> list.stream()
                .filter(i -> i % 2 != 0)
                .collect(Collectors.toList());
 
        Function<List<Integer>, Integer> reducerSum = list -> list.stream()
                .reduce(Integer::sum).orElse(0);
 
        Function<List<Integer>, Integer> reducerMax = list -> list.stream()
                .max(Integer::compare).orElse(0);
 
        // pipeline
        values = adder.apply(values);
        System.out.println("After adding: " + values);
        values = multiplier.apply(values);
        System.out.println("After multiplying: " + values);
        values = filterEven.apply(values);
        System.out.println("After filtering even numbers: " + values);
        int sum = reducerSum.apply(values);
        System.out.println("Sum of remaining numbers: " + sum);
        int max = reducerMax.apply(values);
        System.out.println("Maximum of remaining numbers: " + max);
    }
 
    private static String readLine(String prompt) {
        System.out.print(prompt);
        try {
            return new java.util.Scanner(System.in).nextLine();
        } catch (Exception e) {
            return "";
        }
    }
}
