import sys

def parse_line(line):
    trimmed = line.strip()
    return list(map(int, trimmed.split())) if trimmed else []

lines = sys.stdin.read().split('\n')
a = parse_line(lines[0])
b = parse_line(lines[1])
result = []
i = 0
j = 0

while i < len(a) and j < len(b):
    if a[i] <= b[j]:
        result.append(a[i])
        i += 1
    else:
        result.append(b[j])
        j += 1

while i < len(a):
    result.append(a[i])
    i += 1

while j < len(b):
    result.append(b[j])
    j += 1

if result:
    print(' '.join(map(str, result)))
