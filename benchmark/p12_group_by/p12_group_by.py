import sys


def main():
    n = int(sys.stdin.readline())
    sums = {}
    counts = {}
    for _ in range(n):
        parts = sys.stdin.readline().split()
        key = parts[0]
        value = int(parts[1])
        if key not in sums:
            sums[key] = 0
            counts[key] = 0
        sums[key] += value
        counts[key] += 1
    for key in sorted(sums.keys()):
        print(key, sums[key], counts[key])


main()
