package results.raw.base01.p13_n_queens.scheme_to_java;

import java.util.Scanner;
import java.io.PrintWriter;

public class P13NQueens {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        PrintWriter writer = new PrintWriter(System.out);

        int n = Integer.parseInt(scanner.nextLine());
        int result = nQueensCount(n);
        writer.println(result);
        writer.flush();
    }

    private static boolean safe(int[] queens, int col) {
        int row = queens.length - 1;
        for (int i = 0; i < row; i++) {
            if (queens[i] == col || Math.abs(queens[i] - col) == row - i) {
                return false;
            }
        }
        return true;
    }

    private static int count(int row, int n, int[] queens) {
        if (row == n) {
            return 1;
        }
        int total = 0;
        for (int col = 0; col < n; col++) {
            if (safe(queens, col)) {
                queens[row] = col;
                total += count(row + 1, n, queens);
            }
        }
        return total;
    }

    private static int nQueensCount(int n) {
        int[] queens = new int[n];
        return count(0, n, queens);
    }
}
