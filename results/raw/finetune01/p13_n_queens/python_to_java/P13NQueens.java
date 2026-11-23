public class NQueens {
 
    public static boolean isSafe(int board[][], int row, int col, int n){
        //check this column on left side
        for (int i = 0; i < col; i++)
            if (board[row][i] == 1)
                return false;
 
        // Check upper diagonal on left side
        for (int i=row, j=col; i>=0 && j>=0; i--, j--)
            if (board[i][j] == 1)
                return false;
 
        // Check lower diagonal on left side
        for (int i=row, j=col; j>=0 && i<n; i++, j--)
            if (board[i][j] == 1)
                return false;
 
        return true;
    }
 
    /* A recursive utility function to solve N Queen problem */
    public static boolean solveNQUtil(int board[][], int col, int n){
        /* base case: If all queens are placed then return true */
        if (col >= n)
            return true;
 
        /* Consider this column and try placing this queen in all rows one by one */
        for (int i = 0; i < n; i++){
            /* Check if queen can be placed on board[i][col] */
            if (isSafe(board, i, col, n)){
                /* Place this queen in board[i][col] */
                board[i][col] = 1;
 
                /* recur to place rest of the queens */
                if (solveNQUtil(board, col+1, n))
                    return true;
 
                /* If placing queen in board[i][col] doesn't lead to a solution
                   then remove queen from board[i][col] */
                board[i][col] = 0; // BACKTRACK
            }
        }
 
        /* if queen can not be place in any row in this column col then return false */
        return false;
    }
 
    /* This function solves the N Queen problem using Backtracking. It mainly uses solveNQUtil() to solve the problem. It returns false if queens cannot be placed, otherwise return true and prints placement of queens in the form of 1s. Please note that there may be more than one solutions. This function prints one of the feasible solutions.*/
    public static boolean solveNQ(int n){
        int board[][] = new int[n][n];
 
        if (solveNQUtil(board, 0, n) == false){
            System.out.print("Solution does not exist");
            return false;
        }
 
        printBoard(board);
        return true;
    }
 
    /* A utility function to print solution */
    public static void printBoard(int board[][]){
        for (int i=0; i<board.length; i++){
            for (int j=0; j<board.length; j++)
                System.out.print(" " + board[i][j]);
            System.out.println();
        }
    }
 
    public static void main(String args[]){
        int n = 8;
        solveNQ(n);
    }
}
