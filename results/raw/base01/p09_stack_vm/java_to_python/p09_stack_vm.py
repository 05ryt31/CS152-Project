import sys

def main():
    n = int(input())
    stack = []

    for _ in range(n):
        parts = input().split()
        op = parts[0]

        if op == "push":
            stack.append(int(parts[1]))
        elif op == "pop":
            if not stack:
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
            if not stack:
                print("error")
            else:
                stack.append(stack[-1])
        elif op == "swap":
            if len(stack) < 2:
                print("error")
            else:
                b = stack.pop()
                a = stack.pop()
                stack.append(a)
                stack.append(b)
        elif op == "print":
            if not stack:
                print("error")
            else:
                print(stack[-1])

if __name__ == "__main__":
    main()
