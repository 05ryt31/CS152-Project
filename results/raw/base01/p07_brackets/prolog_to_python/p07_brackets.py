import sys

def safe_read_line():
    try:
        return input()
    except EOFError:
        return ""

def run(n):
    if n == 0:
        return
    line = safe_read_line()
    if balanced(line):
        print("yes")
    else:
        print("no")
    run(n - 1)

def balanced(line):
    stack = []
    for char in line:
        if char in "([{":
            stack.append(char)
        elif char in ")]}":
            if not stack or not matching(stack.pop(), char):
                return False
    return not stack

def matching(open_char, close_char):
    match {
        '(': ')',
        '[': ']',
        '{': '}'
    }.get(open_char, None) == close_char

if __name__ == "__main__":
    n_line = safe_read_line()
    n = int(n_line)
    run(n)
    sys.exit(0)
