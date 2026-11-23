import java.util.*;
 
public class Dedupe {
    public static void main(String[] args) {
        String s = "1 2 3 4 5 6 7 8 9 10 1 2 3 4 5";
        System.out.println(dedup(s));
    }
 
    private static String dedup(String s) {
        Set<Integer> set = new HashSet<>();
        String[] tokens = s.split(" ");
        for (String token : tokens)
            set.add(Integer.parseInt(token));
        return set.toString().replaceAll("[\\[\\] ]", "");
    }
}
