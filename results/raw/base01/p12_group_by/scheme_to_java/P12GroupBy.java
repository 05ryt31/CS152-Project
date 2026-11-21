package results.raw.base01.p12_group_by.scheme_to_java;

import java.util.*;

public class P12GroupBy {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        List<List<Object>> groups = readGroups(n, scanner);
        printGroups(groups);
        System.exit(0);
    }

    private static List<List<Object>> readGroups(int n, Scanner scanner) {
        List<List<Object>> groups = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            String[] parts = scanner.nextLine().split(" ");
            update(parts[0], Integer.parseInt(parts[1]), groups);
        }
        return groups;
    }

    private static void update(String key, int value, List<List<Object>> groups) {
        Iterator<List<Object>> iterator = groups.iterator();
        while (iterator.hasNext()) {
            List<Object> group = iterator.next();
            if (key.equals(group.get(0))) {
                group.set(1, (Integer) group.get(1) + value);
                group.set(2, (Integer) group.get(2) + 1);
                return;
            }
        }
        groups.add(Arrays.asList(key, value, 1));
    }

    private static void printGroups(List<List<Object>> groups) {
        Collections.sort(groups, Comparator.comparing(o -> (String) o.get(0)));
        for (List<Object> group : groups) {
            System.out.println(group.get(0) + " " + group.get(1) + " " + group.get(2));
        }
    }
}
