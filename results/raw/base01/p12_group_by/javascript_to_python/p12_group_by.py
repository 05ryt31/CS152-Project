import sys

lines = sys.stdin.read().split('\n')
n = int(lines[0])

groups = {}
for i in range(n):
    key, raw = lines[i + 1].split()
    value = int(raw)
    if key in groups:
        groups[key][0] += value
        groups[key][1] += 1
    else:
        groups[key] = [value, 1]

for key in sorted(groups.keys()):
    print(key, *groups[key])
