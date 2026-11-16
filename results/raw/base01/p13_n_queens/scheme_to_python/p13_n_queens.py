import sys

def safe(queens, col):
    dist = len(queens)
    return all(abs(col - q) != dist for q in queens)

def count(row, queens):
    if row == n:
        return 1
    total = 0
    for col in range(n):
        if safe(queens, col):
            total += count(row + 1, queens + [col])
    return total

n = int(input())
print(count(0, []))
