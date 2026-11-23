function solveNQueens(n) {
    var board = [];
    for (var i = 0; i < n; i++) {
        board[i] = [];
        for (var j = 0; j < n; j++)
            board[i][j] = false;
    }
 
    function canPlaceQueen(row, col) {
        // check if there is no queen in this column
        for (var i = 0; i < n; i++)
            if (board[i][col])
                return false;
 
        // check if there is no queen in this diagonal
        for (var i = 0; i < n; i++)
            for (var j = 0; j < n; j++)
                if (Math.abs(i - row) == Math.abs(j - col) && board[i][j])
                    return false;
 
        return true;
    }
 
    function placeQueen(row, col) {
        board[row][col] = true;
    }
 
    function removeQueen(row, col) {
        board[row][col] = false;
    }
 
    function printBoard() {
        console.log("Solution:");
        for (var i = 0; i < n; i++) {
            for (var j = 0; j < n; j++)
                process.stdout.write(board[i][j] ? "Q" : ".");
            console.log();
        }
    }
 
    function solve(row) {
        if (row >= n)
            return true;
 
        for (var col = 0; col < n; col++) {
            if (canPlaceQueen(row, col)) {
                placeQueen(row, col);
                if (solve(row + 1))
                    return true;
                removeQueen(row, col);
            }
        }
 
        return false;
    }
 
    if (!solve(0))
        throw new Error("No solution");
 
    printBoard();
}
 
// test
for (var i = 4; i <= 15; i += 2)
    solveNQueens(i);
