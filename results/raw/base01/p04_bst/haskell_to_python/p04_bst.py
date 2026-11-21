class TreeNode:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

def insert(root, value):
    if root is None:
        return TreeNode(value)
    if value < root.value:
        root.left = insert(root.left, value)
    else:
        root.right = insert(root.right, value)
    return root

def inorder_traversal(node):
    if node is None:
        return []
    return inorder_traversal(node.left) + [node.value] + inorder_traversal(node.right)

def preorder_traversal(node):
    if node is None:
        return []
    return [node.value] + preorder_traversal(node.left) + preorder_traversal(node.right)

def height(node):
    if node is None:
        return 0
    return 1 + max(height(node.left), height(node.right))

def main():
    import sys
    input_line = sys.stdin.read().strip()
    values = list(map(int, input_line.split()))
    root = None
    for value in values:
        root = insert(root, value)
    
    print(' '.join(map(str, inorder_traversal(root))))
    print(' '.join(map(str, preorder_traversal(root))))
    print(height(root))

if __name__ == "__main__":
    main()
