import sys

def insert(tree, value):
    if not tree:
        return [value, [], []]
    root = tree[0]
    if value < root:
        return [root, insert(tree[1], value), tree[2]]
    return [root, tree[1], insert(tree[2], value)]

def inorder(tree):
    if not tree:
        return []
    return inorder(tree[1]) + [tree[0]] + inorder(tree[2])

def preorder(tree):
    if not tree:
        return []
    return [tree[0]] + preorder(tree[1]) + preorder(tree[2])

def height(tree):
    if not tree:
        return 0
    return 1 + max(height(tree[1]), height(tree[2]))

def print_list(values):
    if values:
        print(values[0], end='')
        for value in values[1:]:
            print(f" {value}", end='')
        print()

def numbers(line):
    return list(map(int, line.split())) if line else []

def safe_read_line():
    try:
        return input().strip()
    except EOFError:
        return ""

def build_tree(values):
    def loop(loop_values, tree):
        if not loop_values:
            return tree
        return loop(loop_values[1:], insert(tree, loop_values[0]))
    return loop(values, [])

tree = build_tree(numbers(safe_read_line()))
print_list(inorder(tree))
print_list(preorder(tree))
print(height(tree))
