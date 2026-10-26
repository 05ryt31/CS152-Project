package benchmark.p13_n_queens;

import java.io.*;

public class P13NQueens {
    static boolean safe(int[] columns, int row, int col) {
        for (int previous = 0; previous < row; previous++) {
            if (columns[previous] == col || Math.abs(columns[previous] - col) == row - previous) return false;
        }
        return true;
    }

    static int count(int n, int row, int[] columns) {
        if (row == n) return 1;

        int total = 0;
        for (int col = 0; col < n; col++) {
            if (safe(columns, row, col)) {
                columns[row] = col;
                total += count(n, row + 1, columns);
            }
        }

        return total;
    }

    public static void main(String[] args) throws Exception {
        int n = Integer.parseInt(new BufferedReader(new InputStreamReader(System.in)).readLine());
        System.out.println(count(n, 0, new int[n]));
    }
}
