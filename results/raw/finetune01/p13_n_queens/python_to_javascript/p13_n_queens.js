function solveNQueens(n) {
    var board = [];
    for (var i = 0; i < n; i++) {
        board[i] = [];
        for (var j = 0; j < n; j++)
            board[i][j] = false;
    }
 
    function canPlaceQueen(board, row, col) {
        // check this column on previous rows
        for (var i = 0; i < row; i++)
            if (board[i][col])
                return false;
 
        // check upper diagonal on left side
        for (i = row, j = col; i >= 0 && j >= 0; i--, j--)
            if (board[i][j])
                return false;
 
        // check upper diagonal on right side
        for (i = row, j = col; j < n && i >= 0; i--, j++)
            if (board[i][j])
                return false;
 
        return true;
    }
 
    function placeQueen(board, row) {
        if (row === n)
            return true;
 
        for (var i = 0; i < n; i++) {
            if (canPlaceQueen(board, row, i)) {
                board[row][i] = true;
                if (placeQueen(board, row + 1))
                    return true;
                board[row][i] = false;
            }
        }
 
        return false;
    }
 
    placeQueen(board, 0);
 
    var solutions = [];
    for (var i = 0; i < n; i++) {
        var solution = [];
        for (var j = 0; j < n; j++)
            if (board[i][j]) solution.push(j + 1);
        solutions.push(solution);
    }
 
    return solutions;
}
 
// test
for (var i = 4; i <= 15; i++)
    console.log(i + ': ' + solveNQueens(i).length);
