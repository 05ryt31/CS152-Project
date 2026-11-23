import java.util.ArrayList;
import java.util.List;
 
public class NQueens {
 
    public static List<List<Integer>> solveNQueens(int n) {
        List<List<Integer>> solutions = new ArrayList<>();
        int[] board = new int[n];
        placeQueens(board, 0, solutions);
        return solutions;
    }
 
    private static boolean placeQueens(int[] board, int row, List<List<Integer>> solutions) {
        if (row == board.length) {
            solutions.add(toSolution(board));
            return true;
        } else {
            for (int col = 0; col < board.length; col++) {
                if (isSafe(board, row, col)) {
                    board[row] = col;
                    if (placeQueens(board, row + 1, solutions))
                        return true;
                }
            }
            return false;
        }
    }
 
    private static boolean isSafe(int[] board, int row, int col) {
        for (int r = 0; r < row; r++)
            if (board[r] == col || Math.abs(r - row) == Math.abs(board[r] - col))
                return false;
        return true;
    }
 
    private static List<Integer> toSolution(int[] board) {
        List<Integer> solution = new ArrayList<>();
        for (int i = 0; i < board.length; i++)
            solution.add(i * 10 + board[i]);
        return solution;
    }
 
    public static void main(String[] args) {
        System.out.println(solveNQueens(8));
    }
}
