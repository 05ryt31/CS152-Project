import sys

def matching(opener, closer):
    return (opener == '(' and closer == ')') or \
           (opener == '[' and closer == ']') or \
           (opener == '{' and closer == '}')

def balanced(text):
    stack = []
    for char in text:
        if char in '([{':
            stack.append(char)
        elif char in ')]}':
            if not stack or not matching(stack.pop(), char):
                return False
    return not stack

n = int(input())
for _ in range(n):
    print("yes" if balanced(input()) else "no")
