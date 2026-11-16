def safe(columns, row, col):
    for previous in range(row):
        if columns[previous] == col or abs(columns[previous] - col) == row - previous:
            return False
    return True

def count(n, row, columns):
    if row == n:
        return 1

    total = 0
    for col in range(n):
        if safe(columns, row, col):
            columns[row] = col
            total += count(n, row + 1, columns)

    return total

if __name__ == "__main__":
    import sys
    n = int(input())
    print(count(n, 0, [0] * n))
