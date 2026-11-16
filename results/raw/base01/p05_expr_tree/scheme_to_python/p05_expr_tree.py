import sys

def build(tokens):
    stack = []
    for token in tokens:
        if token in "+-*":
            right = stack.pop()
            left = stack.pop()
            stack.append([token, left, right])
        else:
            stack.append(token)
    return stack[0]

def render(tree):
    if isinstance(tree, str):
        return tree
    return f"({render(tree[1])} {tree[0]} {render(tree[2])})"

tokens = input().split()
result = render(build(tokens))
print(result)
