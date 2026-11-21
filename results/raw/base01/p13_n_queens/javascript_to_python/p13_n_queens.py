def safe(columns, row, col):
    for previous in range(row):
        if columns[previous] == col or abs(columns[previous] - col) == row - previous:
            return False
    return True

def count(row, columns):
    if row == n:
        return 1
    
    total = 0
    for col in range(n):
        if safe(columns, row, col):
            columns[row] = col
            total += count(row + 1, columns)
    
    return total

n = int(input().strip())
print(count(0, [None] * n))
