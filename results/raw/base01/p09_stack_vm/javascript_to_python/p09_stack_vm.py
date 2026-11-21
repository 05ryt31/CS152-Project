import sys

lines = sys.stdin.read().split('\n')
n = int(lines[0])

stack = []
output = []

for i in range(n):
    parts = lines[i + 1].split()
    op = parts[0]
    if op == 'push':
        stack.append(int(parts[1]))
    elif op == 'pop':
        if not stack:
            output.append('error')
        else:
            stack.pop()
    elif op == 'add' or op == 'mul':
        if len(stack) < 2:
            output.append('error')
        else:
            b = stack.pop()
            a = stack.pop()
            stack.append(a + b if op == 'add' else a * b)
    elif op == 'dup':
        if not stack:
            output.append('error')
        else:
            stack.append(stack[-1])
    elif op == 'swap':
        if len(stack) < 2:
            output.append('error')
        else:
            stack[-1], stack[-2] = stack[-2], stack[-1]
    else:
        output.append(str(stack[-1]) if stack else 'error')

if output:
    print('\n'.join(output))
