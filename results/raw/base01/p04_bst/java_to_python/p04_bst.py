class Node:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

def insert(root, value):
    if root is None:
        return Node(value)
    current = root
    while True:
        if value < current.value:
            if current.left is None:
                current.left = Node(value)
                return root
            current = current.left
        else:
            if current.right is None:
                current.right = Node(value)
                return root
            current = current.right

def inorder(node, out):
    if node is not None:
        inorder(node.left, out)
        if out:
            out.append(' ')
        out.append(str(node.value))
        inorder(node.right, out)

def preorder(node, out):
    if node is not None:
        if out:
            out.append(' ')
        out.append(str(node.value))
        preorder(node.left, out)
        preorder(node.right, out)

def height(node):
    return 0 if node is None else 1 + max(height(node.left), height(node.right))

if __name__ == "__main__":
    import sys
    line = input().strip()
    if not line:
        line = ""

    root = None
    for token in line.split():
        if token:
            root = insert(root, int(token))

    in_order = []
    preorder_list = []
    inorder(root, in_order)
    preorder(root, preorder_list)

    print("".join(in_order))
    print("".join(preorder_list))
    print(height(root))
