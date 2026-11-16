def balanced(text):
    if text is None:
        return True
    stack = []
    for c in text:
        if c in '([{':
            stack.append(c)
        else:
            if not stack or (c == ')' and stack[-1] != '(') or \
               (c == ']' and stack[-1] != '[') or (c == '}' and stack[-1] != '{'):
                return False
            stack.pop()
    return not stack

if __name__ == "__main__":
    import sys
    reader = sys.stdin
    n = int(next(reader))
    for _ in range(n):
        line = next(reader).strip()
        print("yes" if balanced(line) else "no")
