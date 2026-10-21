import sys


def safe(columns, row, col):
    for prev_row in range(row):
        prev_col = columns[prev_row]
        if prev_col == col or abs(prev_col - col) == row - prev_row:
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


def main():
    n = int(sys.stdin.readline())
    print(count(n, 0, [0] * n))


main()
