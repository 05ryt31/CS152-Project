package results.raw.base01.p14_bfs.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;

public class P14Bfs {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String[] nm = reader.readLine().split(" ");
            int n = Integer.parseInt(nm[0]);
            int m = Integer.parseInt(nm[1]);

            Map<Integer, LinkedList<Integer>> neighbors = new HashMap<>();
            for (int i = 1; i <= n; i++) {
                neighbors.put(i, new LinkedList<>());
            }

            for (int i = 0; i < m; i++) {
                String[] uv = reader.readLine().split(" ");
                int u = Integer.parseInt(uv[0]);
                int v = Integer.parseInt(uv[1]);
                neighbors.get(u).add(v);
                neighbors.get(v).add(u);
            }

            String[] st = reader.readLine().split(" ");
            int s = Integer.parseInt(st[0]);
            int t = Integer.parseInt(st[1]);

            Map<Integer, Integer> distance = new HashMap<>();
            distance.put(s, 0);
            Queue<Integer> queue = new LinkedList<>();
            queue.add(s);

            while (!queue.isEmpty()) {
                int node = queue.poll();
                if (node == t) {
                    break;
                }
                for (int other : neighbors.get(node)) {
                    if (!distance.containsKey(other)) {
                        distance.put(other, distance.get(node) + 1);
                        queue.add(other);
                    }
                }
            }

            if (distance.containsKey(t)) {
                System.out.println(distance.get(t));
            } else {
                System.out.println(-1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
