public class NQueens {
 
    public static int solve(int n) {
        int[][] board = new int[n][n];
        return solve(board, 0);
    }
 
    private static int solve(int[][] board, int row) {
        if (row == board.length)
            return 1;
        int count = 0;
        for (int i = 0; i < board.length; i++)
            if (isSafe(board, row, i))
                count += solve(setQueen(board, row, i), row + 1);
        return count;
    }
 
    private static boolean isSafe(int[][] board, int row, int col) {
        for (int i = 0; i < board.length; i++)
            if (board[row][i] == 1 || board[i][col] == 1)
                return false;
        for (int i = 0; i < board.length; i++)
            for (int j = 0; j < board.length; j++)
                if ((Math.abs(i - row) == Math.abs(j - col)) && board[i][j] == 1)
                    return false;
        return true;
    }
 
    private static int[][] setQueen(int[][] board, int row, int col) {
        for (int i = 0; i < board.length; i++)
            board[row][i] = board[i][col] = 1;
        for (int i = 0; i < board.length; i++)
            for (int j = 0; j < board.length; j++)
                if (Math.abs(i - row) == Math.abs(j - col))
                    board[i][j] = 1;
        board[row][col] = 2;
        return board;
    }
 
    public static void main(String[] args) {
        System.out.println(solve(Integer.parseInt(args[0])));
    }
}
