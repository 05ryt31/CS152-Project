import sys


def main():
    n = int(sys.stdin.readline())
    stack = []
    for _ in range(n):
        parts = sys.stdin.readline().split()
        op = parts[0]
        if op == "push":
            stack.append(int(parts[1]))
        elif op == "pop":
            if len(stack) < 1:
                print("error")
            else:
                stack.pop()
        elif op == "add" or op == "mul":
            if len(stack) < 2:
                print("error")
            else:
                b = stack.pop()
                a = stack.pop()
                if op == "add":
                    stack.append(a + b)
                else:
                    stack.append(a * b)
        elif op == "dup":
            if len(stack) < 1:
                print("error")
            else:
                stack.append(stack[-1])
        elif op == "swap":
            if len(stack) < 2:
                print("error")
            else:
                stack[-1], stack[-2] = stack[-2], stack[-1]
        elif op == "print":
            if len(stack) < 1:
                print("error")
            else:
                print(stack[-1])


main()
