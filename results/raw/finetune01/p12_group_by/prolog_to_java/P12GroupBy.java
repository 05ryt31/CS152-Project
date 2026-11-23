import java.util.*;
 
public class GroupBy {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the number of lines:");
        int nLines = Integer.parseInt(scanner.nextLine());
        Map<Integer, List<String>> map = new HashMap<>();
        while (nLines-- > 0) {
            String[] tokens = scanner.nextLine().split("\\s+");
            int key = Integer.parseInt(tokens[0]);
            if (!map.containsKey(key)) {
                map.put(key, new ArrayList<>());
            }
            map.get(key).add(tokens[1]);
        }
        for (Map.Entry<Integer, List<String>> entry : map.entrySet()) {
            System.out.printf("%d %s%n", entry.getKey(), entry.getValue());
        }
    }
}
