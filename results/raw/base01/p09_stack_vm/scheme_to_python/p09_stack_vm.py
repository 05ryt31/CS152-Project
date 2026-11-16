import sys

def stack_vm(n):
    stack = []
    i = 0
    while i < n:
        parts = input().split()
        op = parts[0]
        if op == "push":
            stack.append(int(parts[1]))
        elif op == "pop":
            if not stack:
                print("error")
            else:
                stack.pop()
        elif op in ["add", "mul"]:
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
                stack[-1], stack[-2] = stack[-2], stack[-1]
        else:
            if not stack:
                print("error")
            else:
                print(stack[-1])
        i += 1

n = int(input())
stack_vm(n)
