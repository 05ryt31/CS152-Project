import java.util.*;
 
public class Bfs {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        int m = Integer.parseInt(scanner.nextLine());
        List<Integer>[] graph = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int i = 0; i < m; i++) {
            String[] edge = scanner.nextLine().split(" ");
            int u = Integer.parseInt(edge[0]);
            int v = Integer.parseInt(edge[1]);
            graph[u].add(v);
            graph[v].add(u);
        }
        int s = Integer.parseInt(scanner.nextLine());
        int t = Integer.parseInt(scanner.nextLine());
        System.out.println(bfs(graph, s, t));
    }
 
    private static int bfs(List<Integer>[] graph, int s, int t) {
        Queue<Integer> queue = new LinkedList<>();
        boolean[] seen = new boolean[graph.length];
        queue.add(s);
        seen[s] = true;
        while (!queue.isEmpty()) {
            int node = queue.poll();
            if (node == t) return 1;
            for (Integer neighbor : graph[node]) {
                if (!seen[neighbor]) {
                    seen[neighbor] = true;
                    queue.add(neighbor);
                }
            }
        }
        return -1;
    }
}
