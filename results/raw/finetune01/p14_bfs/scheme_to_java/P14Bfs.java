import java.util.*;
 
public class Bfs {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        int m = in.nextInt();
        List<Integer>[] g = new ArrayList[n];
        for (int i = 0; i < n; ++i) g[i] = new ArrayList<>();
        for (int i = 0; i < m; ++i) {
            int u = in.nextInt() - 1;
            int v = in.nextInt() - 1;
            g[u].add(v);
            g[v].add(u);
        }
        int s = in.nextInt() - 1;
        int t = in.nextInt() - 1;
        System.out.println(bfs(g, s, t));
    }
 
    private static int bfs(List<Integer>[] g, int s, int t) {
        Queue<Integer> q = new LinkedList<>();
        boolean[] seen = new boolean[g.length];
        q.add(s);
        seen[s] = true;
        for (int d = 0; !q.isEmpty(); ++d) {
            for (int sz = q.size(); sz > 0; --sz) {
                int u = q.poll();
                if (u == t) return d;
                for (int v : g[u]) if (!seen[v]) { q.add(v); seen[v] = true; }
            }
        }
        return -1;
    }
}
