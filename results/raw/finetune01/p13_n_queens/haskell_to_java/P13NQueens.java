import java.util.*;
 
public class NQueens {
 
    public static int solve(int n) {
        return solve(n, new ArrayList<Integer>());
    }
 
    private static int solve(int n, List<Integer> columns) {
        if (columns.size() == n) {
            return 1;
        } else {
            int count = 0;
            for (int i = 0; i < n; i++) {
                columns.add(i);
                if (isValid(columns)) {
                    count += solve(n, columns);
                }
                columns.remove(columns.size() - 1);
            }
            return count;
        }
    }
 
    private static boolean isValid(List<Integer> columns) {
        int row = columns.size() - 1;
        int col = columns.get(row);
        for (int i = 0; i < row; i++) {
            int diff = Math.abs(col - columns.get(i));
            if (diff == 0 || diff == row - i) {
                return false;
            }
        }
        return true;
    }
 
    public static void main(String[] args) {
        System.out.println(solve(8)); // 92
    }
}
