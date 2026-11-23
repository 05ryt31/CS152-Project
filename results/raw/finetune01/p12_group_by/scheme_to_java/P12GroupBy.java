import java.util.*;
 
public class GroupBy {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        Map<String, Integer> map = new TreeMap<>();
        while (n-- > 0) {
            String[] s = scanner.nextLine().split(" ");
            String name = s[0];
            int count = Integer.parseInt(s[1]);
            if (map.containsKey(name)) {
                map.put(name, map.get(name) + count);
            } else {
                map.put(name, count);
            }
        }
        for (Map.Entry<String, Integer> e : map.entrySet()) {
            System.out.printf("%s %d\n", e.getKey(), e.getValue());
        }
    }
}
