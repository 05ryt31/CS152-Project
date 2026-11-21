package results.raw.base01.p14_bfs.prolog_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;

public class P14Bfs {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(new BufferedReader(new InputStreamReader(System.in)));
        String firstLine = scanner.nextLine();
        String[] parts = firstLine.split(" ");
        int n = Integer.parseInt(parts[0]);
        int m = Integer.parseInt(parts[1]);

        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int i = 0; i < m; i++) {
            String line = scanner.nextLine();
            parts = line.split(" ");
            int u = Integer.parseInt(parts[0]);
            int v = Integer.parseInt(parts[1]);
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        String lastLine = scanner.nextLine();
        parts = lastLine.split(" ");
        int s = Integer.parseInt(parts[0]);
        int t = Integer.parseInt(parts[1]);

        int result = bfs(graph, s, t);
        System.out.println(result);

        System.exit(0);
    }

    private static int bfs(List<List<Integer>> graph, int start, int target) {
        Queue<int[]> queue = new LinkedList<>();
        Set<Integer> seen = new HashSet<>();
        queue.offer(new int[]{start, 0});
        seen.add(start);

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int node = current[0];
            int distance = current[1];

            if (node == target) {
                return distance;
            }

            for (int neighbor : graph.get(node)) {
                if (!seen.contains(neighbor)) {
                    seen.add(neighbor);
                    queue.offer(new int[]{neighbor, distance + 1});
                }
            }
        }

        return -1;
    }
}
