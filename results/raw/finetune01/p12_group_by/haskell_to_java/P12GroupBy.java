import java.util.*;
 
public class GroupBy {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        List<String> lines = new ArrayList<>();
        while (n-- > 0) {
            lines.add(scanner.nextLine());
        }
        System.out.println(groupBy(lines));
    }
 
    private static String groupBy(List<String> lines) {
        Map<String, Integer> map = new HashMap<>();
        for (String line : lines) {
            String[] parts = line.split(" ");
            if (parts.length == 2) {
                String key = parts[0];
                Integer value = Integer.valueOf(parts[1]);
                map.put(key, map.getOrDefault(key, 0) + value);
            }
        }
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            sb.append(entry.getKey()).append(" ").append(entry.getValue()).append("\n");
        }
        return sb.toString();
    }
}
