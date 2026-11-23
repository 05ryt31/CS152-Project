import java.util.*;
 
public class Dedupe {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        Set<Integer> set = new LinkedHashSet<>();
        for (String s : line.split("\\s+")) {
            set.add(Integer.parseInt(s));
        }
        System.out.println(set);
    }
}
