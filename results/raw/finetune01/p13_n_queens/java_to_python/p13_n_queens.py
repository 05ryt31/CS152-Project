def solveNQ(N):
    def is_not_under_attack(y, x):
        return all(abs(y-yi) != abs(x-xi) for xi,yi in board)

    def place_queen(y, x):
        board.append((y,x))

    def remove_queen():
        board.pop()

    def backtrack(y=0):
        # base case
        if y >= N:
            results.append(list(board))
            return

        for x in range(N):
            if is_not_under_attack(y, x):
                place_queen(y, x)
                backtrack(y+1)
                remove_queen()

    results = []
    board = []
    backtrack()
    return results
 
if __name__ == '__main__':
    print(solveNQ(8))
