import sys

def touch(key):
    if key in values:
        del values[key]
        values[key] = None

lines = sys.stdin.read().split('\n')
capacity = int(lines[0])
n = int(lines[1])

values = {}
output = []
for i in range(n):
    parts = lines[i + 2].split()
    key = int(parts[1])
    if parts[0] == 'get':
        if key in values:
            output.append(str(values[key]))
            touch(key)
        else:
            output.append('-1')
    else:
        if key in values:
            touch(key)
        elif len(values) == capacity:
            values.pop(next(iter(values)))
        values[key] = int(parts[2])

if output:
    print('\n'.join(output))
