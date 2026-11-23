def solveNQueens(n):
    def is_not_under_attack(y, x):
        return not (cols[x] + hills[y - x] + dales[y + x])
 
    def placeQueen(y, x):
        queens.add((y, x))
        cols[x] += 1
        hills[y - x] += 1
        dales[y + x] += 1
 
    def removeQueen(y, x):
        queens.remove((y, x))
        cols[x] -= 1
        hills[y - x] -= 1
        dales[y + x] -= 1
 
    def backtrack(y=0):
        for x in range(n):
            if is_not_under_attack(y, x):
                placeQueen(y, x)
                if y + 1 == n:
                    solutions.append(queens.copy())
                else:
                    backtrack(y + 1)
                removeQueen(y, x)
        return
 
    cols = [0] * n
    hills = [0] * (2 * n - 1)
    dales = [0] * (2 * n - 1)
    queens = set()
    solutions = []
    backtrack()
    return solutions
 
if __name__ == '__main__':
    print(solveNQueens(8))
