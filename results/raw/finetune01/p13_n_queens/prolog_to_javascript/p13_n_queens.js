function solveNQueens(n) {
    var board = [];
    for (var i = 0; i < n; i++) {
        board[i] = [];
        for (var j = 0; j < n; j++)
            board[i][j] = false;
    }
 
    function canPlaceQueen(row, col) {
        // check row
        for (var c = 0; c < n; c++)
            if (board[row][c])
                return false;
 
        // check column
        for (var r = 0; r < n; r++)
            if (board[r][col])
                return false;
 
        // check diagonals
        for (var r = 0; r < n; r++) {
            for (var c = 0; c < n; c++) {
                if ((r+c == row+col || r-c == row-col) && board[r][c])
                    return false;
            }
        }
 
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
            var s = "";
            for (var j = 0; j < n; j++)
                s += board[i][j] ? "Q" : ".";
            console.log(s);
        }
    }
 
    function solve(row) {
        if (row >= n)
            return true;
 
        for (var col = 0; col < n; col++) {
            if (canPlaceQueen(row, col)) {
                placeQueen(row, col);
                if (solve(row+1))
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
for (var i = 4; i <= 15; i+=2)
    solveNQueens(i);
