package results.raw.base01.p13_n_queens.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class P13NQueens {
    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int n = Integer.parseInt(reader.readLine());
        System.out.println(count(n, 0, new int[n]));
    }

    private static boolean safe(int[] columns, int row, int col) {
        for (int prevRow = 0; prevRow < row; prevRow++) {
            int prevCol = columns[prevRow];
            if (prevCol == col || Math.abs(prevCol - col) == row - prevRow) {
                return false;
            }
        }
        return true;
    }

    private static int count(int n, int row, int[] columns) {
        if (row == n) {
            return 1;
        }
        int total = 0;
        for (int col = 0; col < n; col++) {
            if (safe(columns, row, col)) {
                columns[row] = col;
                total += count(n, row + 1, columns);
            }
        }
        return total;
    }
}
