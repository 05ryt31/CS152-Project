import java.util.*;
 
public class GroupBy {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Map<String, Integer> sum = new HashMap<>();
        Map<String, Integer> count = new HashMap<>();
        while (scanner.hasNext()) {
            String[] split = scanner.nextLine().split(" ");
            String key = split[0];
            int value = Integer.parseInt(split[1]);
            sum.putIfAbsent(key, 0);
            count.putIfAbsent(key, 0);
            sum.put(key, sum.get(key) + value);
            count.put(key, count.get(key) + 1);
        }
        List<Map.Entry<String, Integer>> entries = new ArrayList<>(sum.entrySet());
        Collections.sort(entries, Comparator.comparing(Map.Entry::getKey));
        for (Map.Entry<String, Integer> entry : entries) {
            System.out.printf("%s %d %d%n", entry.getKey(), entry.getValue(), count.get(entry.getKey()));
        }
    }
}
