package results.raw.base01.p14_bfs.scheme_to_java;

import java.util.*;

public class P14Bfs {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<Integer> nm = Arrays.stream(scanner.nextLine().split(" "))
                                  .map(Integer::parseInt)
                                  .collect(Collectors.toList());
        int n = nm.get(0);
        int m = nm.get(1);

        Map<Integer, List<Integer>> graph = readGraph(m, scanner);

        List<Integer> st = Arrays.stream(scanner.nextLine().split(" "))
                                  .map(Integer::parseInt)
                                  .collect(Collectors.toList());
        int s = st.get(0);
        int t = st.get(1);

        System.out.println(bfs(s, t, graph));
    }

    private static Map<Integer, List<Integer>> readGraph(int m, Scanner scanner) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int i = 0; i < m; i++) {
            String[] uv = scanner.nextLine().split(" ");
            int u = Integer.parseInt(uv[0]);
            int v = Integer.parseInt(uv[1]);

            graph.putIfAbsent(u, new ArrayList<>());
            graph.putIfAbsent(v, new ArrayList<>());

            graph.get(u).add(v);
            graph.get(v).add(u);
        }
        return graph;
    }

    private static List<Integer> getNeighbors(int node, Map<Integer, List<Integer>> graph) {
        return graph.getOrDefault(node, Collections.emptyList());
    }

    private static List<List<Integer>> expandLayer(List<Integer> layer, Map<Integer, List<Integer>> graph, Set<Integer> visited) {
        List<Integer> next = new ArrayList<>();
        for (int u : layer) {
            if (!visited.contains(u)) {
                visited.add(u);
                for (int v : getNeighbors(u, graph)) {
                    if (!visited.contains(v)) {
                        next.add(v);
                    }
                }
            }
        }
        return Arrays.asList(next, new ArrayList<>(visited));
    }

    private static int bfs(int start, int target, Map<Integer, List<Integer>> graph) {
        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visited = new HashSet<>();
        queue.offer(start);
        visited.add(start);
        int distance = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int current = queue.poll();
                if (current == target) {
                    return distance;
                }
                for (int neighbor : getNeighbors(current, graph)) {
                    if (!visited.contains(neighbor)) {
                        queue.offer(neighbor);
                        visited.add(neighbor);
                    }
                }
            }
            distance++;
        }

        return -1;
    }
}
