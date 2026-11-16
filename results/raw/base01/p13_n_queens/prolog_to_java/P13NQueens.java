package results.raw.base01.p13_n_queens.prolog_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class P13NQueens {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String line = reader.readLine();
            int n = Integer.parseInt(line);
            List<List<Integer>> solutions = new ArrayList<>();
            solveNQueens(n, 0, new ArrayList<>(), solutions);
            System.out.println(solutions.size());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void solveNQueens(int n, int row, List<Integer> columns, List<List<Integer>> solutions) {
        if (row == n) {
            solutions.add(new ArrayList<>(columns));
            return;
        }
        for (int col = 0; col < n; col++) {
            if (isSafe(columns, row, col)) {
                columns.add(col);
                solveNQueens(n, row + 1, columns, solutions);
                columns.remove(columns.size() - 1);
            }
        }
    }

    private static boolean isSafe(List<Integer> columns, int row, int col) {
        for (int i = 0; i < row; i++) {
            if (columns.get(i) == col || Math.abs(columns.get(i) - col) == row - i) {
                return false;
            }
        }
        return true;
    }
}
