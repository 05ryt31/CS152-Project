import sys

PAIRS = {")": "(", "]": "[", "}": "{"}


def balanced(text):
    stack = []
    for ch in text:
        if ch in "([{":
            stack.append(ch)
        else:
            if len(stack) == 0 or stack[-1] != PAIRS[ch]:
                return False
            stack.pop()
    return len(stack) == 0


def main():
    n = int(sys.stdin.readline())
    for _ in range(n):
        line = sys.stdin.readline().rstrip("\n\r")
        if balanced(line):
            print("yes")
        else:
            print("no")


main()
