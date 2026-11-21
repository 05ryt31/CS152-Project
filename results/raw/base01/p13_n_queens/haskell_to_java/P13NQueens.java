package results.raw.base01.p13_n_queens.haskell_to_java;

import java.util.Scanner;
import java.io.PrintWriter;

public class P13NQueens {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        PrintWriter writer = new PrintWriter(System.out);

        int n = Integer.parseInt(scanner.nextLine());
        int result = count(n, 0, new int[0]);
        writer.println(result);
        writer.flush();
    }

    private static boolean safe(int[] cols, int col) {
        for (int i = 0; i < cols.length; i++) {
            if (cols[i] == col || Math.abs(cols[i] - col) == cols.length - i) {
                return false;
            }
        }
        return true;
    }

    private static int count(int n, int row, int[] cols) {
        if (row == n) {
            return 1;
        } else {
            int total = 0;
            for (int col = 0; col < n; col++) {
                if (safe(cols, col)) {
                    total += count(n, row + 1, addColumn(cols, col));
                }
            }
            return total;
        }
    }

    private static int[] addColumn(int[] cols, int col) {
        int[] newCols = new int[cols.length + 1];
        System.arraycopy(cols, 0, newCols, 0, cols.length);
        newCols[cols.length] = col;
        return newCols;
    }
}
