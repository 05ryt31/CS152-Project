import java.util.Arrays;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;
 
public class Pipeline {
 
    public static void main(String[] args) {
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
        System.out.println("Initial list: " + numbers);
 
        // Map functions
        Function<List<Integer>, List<Integer>> addTwo = l -> l.stream().map(i -> i + 2).collect(Collectors.toList());
        Function<List<Integer>, List<Integer>> mulThree = l -> l.stream().map(i -> i * 3).collect(Collectors.toList());
 
        // Filter functions
        Function<List<Integer>, List<Integer>> evens = l -> l.stream().filter(i -> i % 2 == 0).collect(Collectors.toList());
        Function<List<Integer>, List<Integer>> odds = l -> l.stream().filter(i -> i % 2 != 0).collect(Collectors.toList());
        Function<List<Integer>, List<Integer>> gtFour = l -> l.stream().filter(i -> i > 4).collect(Collectors.toList());
 
        // Reduce functions
        Function<List<Integer>, Integer> sum = l -> l.stream().reduce(0, (a, b) -> a + b);
        Function<List<Integer>, Integer> max = l -> l.stream().reduce(Integer.MIN_VALUE, (a, b) -> Math.max(a, b));
 
        // Apply pipeline
        List<Function<List<Integer>, List<Integer>>> pipeline = Arrays.asList(addTwo, evens, mulThree);
        numbers = pipeline.stream().reduce(numbers, (a, f) -> f.apply(a), (a, b) -> null);
        System.out.println("After pipeline: " + numbers);
 
        // Apply reduce pipeline
        pipeline = Arrays.asList(sum, max);
        int result = pipeline.stream().reduce(numbers, (a, f) -> f.apply(a), (a, b) -> 0);
        System.out.println("Reduce result: " + result);
    }
}
