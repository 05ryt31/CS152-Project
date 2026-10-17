import sys

lines = sys.stdin.read().splitlines()
for line in reversed(lines):
    print(line)
