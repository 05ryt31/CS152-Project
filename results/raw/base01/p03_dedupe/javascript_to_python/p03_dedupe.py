import sys

line = sys.stdin.read().strip()
seen = set()
result = []

tokens = line.split()

for token in tokens:
    value = int(token)
    if value not in seen:
        seen.add(value)
        result.append(value)

if result:
    print(' '.join(map(str, result)))
