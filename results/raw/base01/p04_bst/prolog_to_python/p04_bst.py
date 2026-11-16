import sys

class Node:
    def __init__(self, value, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right

def insert(value, tree):
    if tree is None:
        return Node(value)
    elif value < tree.value:
        tree.left = insert(value, tree.left)
    else:
        tree.right = insert(value, tree.right)
    return tree

def inorder(tree, acc):
    if tree is None:
        return acc
    return inorder(tree.left, inorder(tree.right, acc + [tree.value]))

def preorder(tree, acc):
    if tree is None:
        return acc
    return preorder(tree.left, preorder(tree.right, [tree.value] + acc))

def height(tree):
    if tree is None:
        return 0
    return 1 + max(height(tree.left), height(tree.right))

def print_nums(nums):
    print(' '.join(map(str, nums)))

def main():
    lines = sys.stdin.readlines()
    nums = list(map(int, lines[0].split()))
    tree = None
    for num in nums:
        tree = insert(num, tree)
    in_order = inorder(tree, [])
    pre_order = preorder(tree, [])
    print_nums(in_order)
    print_nums(pre_order)
    print(height(tree))

if __name__ == "__main__":
    main()
