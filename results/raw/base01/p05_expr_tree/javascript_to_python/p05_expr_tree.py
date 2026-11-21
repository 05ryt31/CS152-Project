import sys

def render(node):
    if not node['left'] and not node['right']:
        return node['token']
    return f"({render(node['left'])} {node['token']} {render(node['right'])})"

tokens = input().strip().split()
stack = []

for token in tokens:
    if token in '+-*':
        right = stack.pop()
        left = stack.pop()
        stack.append({'token': token, 'left': left, 'right': right})
    else:
        stack.append({'token': token})

print(render(stack[0]))
