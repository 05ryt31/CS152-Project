class Node:
    def __init__(self, value, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right

def insert(root, value):
    node = Node(value)
    if not root:
        return node

    current = root
    while True:
        if value < current.value:
            if not current.left:
                current.left = node
                return root
            current = current.left
        else:
            if not current.right:
                current.right = node
                return root
            current = current.right

def inorder(root, out):
    if root:
        inorder(root.left, out)
        out.append(root.value)
        inorder(root.right, out)

def preorder(root, out):
    if root:
        out.append(root.value)
        preorder(root.left, out)
        preorder(root.right, out)

def height(root):
    return 1 + max(height(root.left), height(root.right)) if root else 0

import sys

line = sys.stdin.read().strip()
values = list(map(int, line.split())) if line else []

root = None
for value in values:
    root = insert(root, value)

in_order = []
inorder(root, in_order)

pre_order = []
preorder(root, pre_order)

print(" ".join(map(str, in_order)))
print(" ".join(map(str, pre_order)))
print(height(root))
