pairs = {')': '(', ']': '[', '}': '{'}

def balanced(text):
    stack = []
    for ch in text:
        if ch in '([{':
            stack.append(ch)
        elif not stack or stack.pop() != pairs.get(ch, ''):
            return False
    return not stack

import sys
lines = sys.stdin.read().split('\n')
n = int(lines[0])
for i in range(n):
    print('yes' if balanced(lines[i + 1] or '') else 'no')
