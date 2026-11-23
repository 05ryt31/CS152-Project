import java.util.*;
 
public class Bfs {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        int m = Integer.parseInt(scanner.nextLine());
        List<Integer>[] adjList = new ArrayList[n];
        for (int i = 0; i < n; i++)
            adjList[i] = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            String[] edge = scanner.nextLine().split(" ");
            int u = Integer.parseInt(edge[0]) - 1;
            int v = Integer.parseInt(edge[1]) - 1;
            adjList[u].add(v);
            adjList[v].add(u);
        }
        int s = Integer.parseInt(scanner.nextLine()) - 1;
        int t = Integer.parseInt(scanner.nextLine()) - 1;
        System.out.println(bfs(adjList, s, t));
    }
 
    private static int bfs(List<Integer>[] adjList, int s, int t) {
        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[adjList.length];
        queue.add(s);
        visited[s] = true;
        while (!queue.isEmpty()) {
            int u = queue.poll();
            if (u == t)
                return 1;
            for (Integer v : adjList[u])
                if (!visited[v]) {
                    visited[v] = true;
                    queue.add(v);
                }
        }
        return -1;
    }
}
