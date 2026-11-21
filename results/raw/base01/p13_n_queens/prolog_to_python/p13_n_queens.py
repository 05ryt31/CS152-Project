import sys

def n_queens(n, row, columns):
    if row == n:
        return [columns]
    results = []
    last = n - 1
    for col in range(last + 1):
        if safe(columns, 1, col):
            new_columns = [col] + columns
            results.extend(n_queens(n, row + 1, new_columns))
    return results

def safe(columns, dist, col):
    for previous in columns:
        if previous == col or abs(previous - col) == dist:
            return False
    return True

def main():
    line = input().strip()
    n = int(line)
    count = sum(len(n_queens(n, 0, [])) for _ in range(1))
    print(count)

if __name__ == "__main__":
    main()
