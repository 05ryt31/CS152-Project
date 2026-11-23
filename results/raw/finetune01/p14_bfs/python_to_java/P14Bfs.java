import java.util.*;
 
public class BFS {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int m = sc.nextInt();
        ArrayList<Integer>[] adjList = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            adjList[i] = new ArrayList<>();
        }
        for (int i = 0; i < m; i++) {
            int u = sc.nextInt() - 1;
            int v = sc.nextInt() - 1;
            adjList[u].add(v);
            adjList[v].add(u);
        }
        int s = sc.nextInt() - 1;
        int t = sc.nextInt() - 1;
        bfs(adjList, s, t);
    }
 
    private static void bfs(ArrayList<Integer>[] adjList, int s, int t) {
        Queue<Integer> q = new LinkedList<>();
        boolean[] visited = new boolean[adjList.length];
        q.add(s);
        visited[s] = true;
        while (!q.isEmpty()) {
            int u = q.poll();
            for (Integer v : adjList[u]) {
                if (!visited[v]) {
                    visited[v] = true;
                    q.add(v);
                }
            }
        }
        System.out.println(visited[t] ? "yes" : "no");
    }
}
