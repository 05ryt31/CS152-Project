def matching(open_char, close_char):
    return (open_char, close_char) in [('(', ')'), ('[', ']'), ('{', '}')]

def balanced(text):
    stack = []
    for char in text:
        if char in "([{":
            stack.append(char)
        elif not stack:
            return False
        elif matching(stack[-1], char):
            stack.pop()
        else:
            return False
    return not stack

def main():
    import sys
    n = int(input())
    lines = [input().strip() for _ in range(n)]
    results = ["yes" if balanced(line) else "no" for line in lines]
    print("\n".join(results))

if __name__ == "__main__":
    main()
