package benchmark.p14_bfs;

import java.io.*;
import java.util.*;

public class P14Bfs {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String[] first = reader.readLine().split("\\s+");
        int n = Integer.parseInt(first[0]);
        int m = Integer.parseInt(first[1]);
        List<List<Integer>> neighbours = new ArrayList<>();

        for (int i = 0; i <= n; i++) neighbours.add(new ArrayList<>());

        for (int i = 0; i < m; i++) {
            String[] edge = reader.readLine().split("\\s+");
            int u = Integer.parseInt(edge[0]);
            int v = Integer.parseInt(edge[1]);
            neighbours.get(u).add(v); 
            neighbours.get(v).add(u);
        }

        String[] last = reader.readLine().split("\\s+");
        int start = Integer.parseInt(last[0]);
        int target = Integer.parseInt(last[1]);
        int[] distance = new int[n + 1]; 
        Arrays.fill(distance, -1);

        Queue<Integer> queue = new ArrayDeque<>(); 
        queue.add(start); 
        distance[start] = 0;
        while (!queue.isEmpty()) {
            int node = queue.remove();
            if (node == target) break;
            for (int other : neighbours.get(node)) {
                if (distance[other] == -1) {
                    distance[other] = distance[node] + 1; 
                    queue.add(other);
                }
            }
        }

        System.out.println(distance[target]);
    }
}
