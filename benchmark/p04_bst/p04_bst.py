import sys


class Node:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None


def insert(root, value):
    node = Node(value)
    if root is None:
        return node
    current = root
    while True:
        if value < current.value:
            if current.left is None:
                current.left = node
                return root
            current = current.left
        else:
            if current.right is None:
                current.right = node
                return root
            current = current.right


def inorder(node, out):
    if node is not None:
        inorder(node.left, out)
        out.append(node.value)
        inorder(node.right, out)


def preorder(node, out):
    if node is not None:
        out.append(node.value)
        preorder(node.left, out)
        preorder(node.right, out)


def height(node):
    if node is None:
        return 0
    return 1 + max(height(node.left), height(node.right))


def main():
    root = None
    for token in sys.stdin.readline().split():
        root = insert(root, int(token))
    in_values = []
    inorder(root, in_values)
    pre_values = []
    preorder(root, pre_values)
    print(" ".join(str(x) for x in in_values))
    print(" ".join(str(x) for x in pre_values))
    print(height(root))


main()
