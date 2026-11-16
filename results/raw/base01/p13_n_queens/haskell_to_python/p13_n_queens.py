def safe(cols, col):
    return all(c != col and abs(c - col) != d for c, d in zip(cols, range(1, len(cols) + 1)))

def count(n, row, cols):
    if row == n:
        return 1
    return sum(count(n, row + 1, cols + [col]) for col in range(n) if safe(cols, col))

if __name__ == "__main__":
    import sys
    n = int(input())
    print(count(n, 0, []))
