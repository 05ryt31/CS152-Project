import java.util.*;
 
public class Dedupe {
    public static void main(String[] args) {
        String s = "1 4 6 7 9 1 2 3 4 5 6 7 8 9";
        System.out.println(dedup(s));
    }
 
    private static String dedup(String s) {
        List<Integer> list = Arrays.asList(s.split(" "))
                .stream()
                .map(Integer::parseInt)
                .distinct()
                .sorted()
                .collect(Collectors.toList());
        return list.stream().map(Object::toString).collect(Collectors.joining(" "));
    }
}
