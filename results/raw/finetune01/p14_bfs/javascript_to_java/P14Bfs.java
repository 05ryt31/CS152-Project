import java.util.*;
 
public class Bfs {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int m = sc.nextInt();
        List<Integer>[] g = new ArrayList[n+1];
        for(int i=1;i<=n;i++)
            g[i]=new ArrayList<>();
        for(int i=0;i<m;i++){
            int u = sc.nextInt();
            int v = sc.nextInt();
            g[u].add(v);
            g[v].add(u);
        }
        int start = sc.nextInt();
        int end = sc.nextInt();
        bfs(g,start,end,n);
    }
 
    private static void bfs(List<Integer>[] g, int start, int end, int n) {
        Queue<Integer> q = new LinkedList<>();
        boolean[] visited = new boolean[n+1];
        q.add(start);
        visited[start]=true;
        while(!q.isEmpty()){
            int u = q.poll();
            if(u==end){
                System.out.println("Distance is "+u);
                return;
            }
            for(Integer v:g[u]){
                if(!visited[v]){
                    q.add(v);
                    visited[v]=true;
                }
            }
        }
    }
}
