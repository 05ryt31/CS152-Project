import java.util.*;
 
public class NQueens {
 
    public static int count(int n) {
        return backtrack(0, new boolean[n], new boolean[2 * n - 1],
                         new boolean[2 * n - 1]);
    }
 
    private static int backtrack(int r, boolean[] cols, boolean[] diag1,
                                  boolean[] diag2) {
        if (r == cols.length) {
            return 1;
        } else {
            int sum = 0;
            for (int c = 0; c < cols.length; ++c) {
                if (!cols[c] && !diag1[r + c] && !diag2[r - c]) {
                    cols[c] = diag1[r + c] = diag2[r - c] = true;
                    sum += backtrack(r + 1, cols, diag1, diag2);
                    cols[c] = diag1[r + c] = diag2[r - c] = false;
                }
            }
            return sum;
        }
    }
 
    public static void main(String[] args) {
        System.out.println(count(8));
    }
}
