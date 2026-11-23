function solveNQueens(n) {
    var board = [];
    for (var i = 0; i < n; i++)
        board[i] = [];
 
    function canPlaceQueen(row, col) {
        // check this column on rows above
        for (var r = 0; r < row; r++)
            if (board[r][col]) return false;
 
        // check upper left diagonal
        for (r = row, c = col; r >= 0 && c >= 0; r--, c--)
            if (board[r][c]) return false;
 
        // check upper right diagonal
        for (r = row, c = col; r >= 0 && c < n; r--, c++)
            if (board[r][c]) return false;
 
        return true;
    }
 
    function placeQueen(row, col) {
        board[row][col] = true;
    }
 
    function removeQueen(row, col) {
        board[row][col] = false;
    }
 
    function printBoard() {
        console.log(board.map(function(row) {
            return row.join(' ');
        }).join('\n'));
    }
 
    function search(row) {
        if (row === n)
            return [board];
        else {
            var solutions = [];
            for (var col = 0; col < n; col++) {
                if (canPlaceQueen(row, col)) {
                    placeQueen(row, col);
                    solutions = solutions.concat(search(row + 1));
                    removeQueen(row, col);
                }
            }
            return solutions;
        }
    }
 
    return search(0);
}
 
// test it out
var solutions = solveNQueens(8);
for (var i = 0; i < solutions.length; i++)
    solutions[i].printBoard();
