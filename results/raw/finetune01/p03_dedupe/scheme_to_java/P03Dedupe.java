import java.util.*;
 
public class Dedupe {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        System.out.print("Enter numbers separated by spaces: ");
        String s = in.nextLine();
        String[] tokens = s.split("\\s+");
        List<Integer> list = new ArrayList<>();
        Set<Integer> set = new HashSet<>();
        for (String token : tokens) {
            int n = Integer.parseInt(token);
            if (!set.contains(n)) {
                set.add(n);
                list.add(n);
            }
        }
        System.out.println(list);
    }
}
