import java.util.*;
 
public class GroupBy {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        Map<String, List<Integer>> map = new HashMap<>();
        while (scanner.hasNextLine()) {
            String[] tokens = scanner.nextLine().split("\\s+");
            String key = tokens[0];
            int value = Integer.parseInt(tokens[1]);
            if (!map.containsKey(key)) {
                map.put(key, new ArrayList<>());
            }
            map.get(key).add(value);
        }
        List<Map.Entry<String, List<Integer>>> list = new ArrayList<>(map.entrySet());
        Collections.sort(list, new Comparator<Map.Entry<String, List<Integer>>>() {
            @Override
            public int compare(Map.Entry<String, List<Integer>> o1, Map.Entry<String, List<Integer>> o2) {
                return o1.getKey().compareTo(o2.getKey());
            }
        });
        for (Map.Entry<String, List<Integer>> entry : list) {
            System.out.print(entry.getKey() + " ");
            for (Integer integer : entry.getValue()) {
                System.out.print(integer + " ");
            }
            System.out.println();
        }
    }
}
