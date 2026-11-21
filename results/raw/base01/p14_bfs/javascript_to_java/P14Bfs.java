package results.raw.base01.p14_bfs.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;

public class P14Bfs {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String[] firstLine = reader.readLine().split("\\s+");
            int n = Integer.parseInt(firstLine[0]);
            int m = Integer.parseInt(firstLine[1]);

            List<Integer>[] graph = new ArrayList[n + 1];
            for (int i = 0; i <= n; i++) {
                graph[i] = new ArrayList<>();
            }

            for (int i = 0; i < m; i++) {
                String[] edge = reader.readLine().split("\\s+");
                int u = Integer.parseInt(edge[0]);
                int v = Integer.parseInt(edge[1]);
                graph[u].add(v);
                graph[v].add(u);
            }

            String[] lastLine = reader.readLine().split("\\s+");
            int start = Integer.parseInt(lastLine[0]);
            int target = Integer.parseInt(lastLine[1]);

            int[] distance = new int[n + 1];
            Arrays.fill(distance, -1);
            Queue<Integer> queue = new LinkedList<>();
            queue.add(start);
            distance[start] = 0;

            while (!queue.isEmpty()) {
                int node = queue.poll();
                if (node == target) {
                    System.out.println(distance[target]);
                    return;
                }
                for (int next : graph[node]) {
                    if (distance[next] < 0) {
                        distance[next] = distance[node] + 1;
                        queue.add(next);
                    }
                }
            }

            System.out.println(distance[target]);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
