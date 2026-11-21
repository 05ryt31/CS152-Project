package results.raw.base01.p14_bfs.haskell_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;

public class P14Bfs {
    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        List<Integer> nums = readNums(reader.readLine());
        int n = nums.get(0);
        int m = nums.get(1);

        List<List<Integer>> edges = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            edges.add(readNums(reader.readLine()));
        }

        nums = readNums(reader.readLine());
        int s = nums.get(0);
        int t = nums.get(1);

        Map<Integer, List<Integer>> graph = buildGraph(edges);
        int result = bfs(graph, s, t);

        System.out.println(result);
    }

    private static List<Integer> readNums(String s) {
        return Arrays.stream(s.split(" "))
                     .map(Integer::parseInt)
                     .toList();
    }

    private static Map<Integer, List<Integer>> buildGraph(List<List<Integer>> edges) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (List<Integer> edge : edges) {
            int u = edge.get(0);
            int v = edge.get(1);
            graph.computeIfAbsent(u, k -> new ArrayList<>()).add(v);
            graph.computeIfAbsent(v, k -> new ArrayList<>()).add(u);
        }
        return graph;
    }

    private static int bfs(Map<Integer, List<Integer>> graph, int start, int target) {
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

            for (int neighbor : graph.getOrDefault(node, List.of())) {
                if (!seen.contains(neighbor)) {
                    seen.add(neighbor);
                    queue.offer(new int[]{neighbor, distance + 1});
                }
            }
        }

        return -1;
    }
}
