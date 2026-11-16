class Tree:
    def __init__(self, value, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right

def build_tree(line):
    tokens = line.split()
    return foldl(step, [], tokens)

def step(stack, token):
    if len(stack) >= 2 and token in "+-*":
        right = stack.pop()
        left = stack.pop()
        return [Tree(token, left, right)] + stack
    else:
        return [Tree(token)] + stack

def render(tree):
    if tree.left is None and tree.right is None:
        return tree.value
    else:
        return f"({render(tree.left)} {tree.value} {render(tree.right)})"

if __name__ == "__main__":
    import sys
    line = sys.stdin.read().strip()
    print(render(build_tree(line)))
