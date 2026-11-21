import sys

def main():
    line = input().strip()
    tokens = line.split()
    tree = build(tokens)
    text = render(tree)
    print(text)

def build(tokens):
    stack = []
    for token in tokens:
        if token in "+-*":
            right = stack.pop()
            left = stack.pop()
            stack.append(('op', token, left, right))
        else:
            stack.append(('leaf', token))
    return stack[0]

def render(node):
    if node[0] == 'leaf':
        return node[1]
    elif node[0] == 'op':
        op, left, right = node[1:]
        l_text = render(left)
        r_text = render(right)
        return f"({l_text} {op} {r_text})"

if __name__ == "__main__":
    main()
