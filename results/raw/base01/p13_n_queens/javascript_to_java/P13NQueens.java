package results.raw.base01.p13_n_queens.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Scanner;

public class P13NQueens {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new BufferedReader(new InputStreamReader(System.in)))) {
            int n = Integer.parseInt(scanner.nextLine().trim());
            System.out.println(count(0, new int[n]));
        }
    }

    private static boolean safe(int[] columns, int row, int col) {
        for (int previous = 0; previous < row; previous++) {
            if (columns[previous] == col || Math.abs(columns[previous] - col) == row - previous) {
                return false;
            }
        }
        return true;
    }

    private static int count(int row, int[] columns) {
        if (row == columns.length) return 1;

        int total = 0;
        for (int col = 0; col < columns.length; col++) {
            if (safe(columns, row, col)) {
                columns[row] = col;
                total += count(row + 1, columns);
            }
        }

        return total;
    }
}
