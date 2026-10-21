import sys


class Node:
    def __init__(self, token, left=None, right=None):
        self.token = token
        self.left = left
        self.right = right


def build(tokens):
    stack = []
    for token in tokens:
        if token in ("+", "-", "*"):
            right = stack.pop()
            left = stack.pop()
            stack.append(Node(token, left, right))
        else:
            stack.append(Node(token))
    return stack[-1]


def render(node):
    if node.left is None and node.right is None:
        return node.token
    return "(" + render(node.left) + " " + node.token + " " + render(node.right) + ")"


def main():
    tokens = sys.stdin.readline().split()
    tree = build(tokens)
    print(render(tree))


main()
