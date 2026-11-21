class Node:
    def __init__(self, token, left=None, right=None):
        self.token = token
        self.left = left
        self.right = right

def render(node):
    if node.left is None and node.right is None:
        return node.token
    return f"({render(node.left)} {node.token} {render(node.right)})"

def main():
    tokens = input().split()
    stack = []

    for token in tokens:
        if token in "+-*":
            right = stack.pop()
            left = stack.pop()
            parent = Node(token, left, right)
            stack.append(parent)
        else:
            stack.append(Node(token))

    print(render(stack.pop()))

if __name__ == "__main__":
    main()
