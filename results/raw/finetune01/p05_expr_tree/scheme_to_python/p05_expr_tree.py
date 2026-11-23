```python
from collections import deque
 
def build(tokens):
    stack = []
    for token in reversed(tokens):
        if token.isdigit():
            stack.append(int(token))
        elif token == '+':
            stack.append(stack.pop() + stack.pop())
        elif token == '-':
            stack.append(-stack.pop() + stack.pop())
        elif token == '*':
            stack.append(stack.pop() * stack.pop())
    return stack[0]
 
if __name__ == '__main__':
    print(build('2 3 4 * +'.split()))
    print(build('2 3 4 * -'.split()))
    print(build('2 3 4 * 5 /'.split()))
    print(build('2 3 4 * 5 / 6 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 +'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 +'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 +'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 +'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 +'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 +'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 +'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 +'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 + 22 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 + 22 * 23 +'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 + 22 * 23 + 24 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 + 22 * 23 + 24 * 25 +'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 + 22 * 23 + 24 * 25 + 26 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 + 22 * 23 + 24 * 25 + 26 * 27 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 + 22 * 23 + 24 * 25 + 26 * 27 * 28 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 + 22 * 23 + 24 * 25 + 26 * 27 * 28 * 29 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 + 22 * 23 + 24 * 25 + 26 * 27 * 28 * 29 * 30 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 + 22 * 23 + 24 * 25 + 26 * 27 * 28 * 29 * 30 * 31 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 19 + 20 * 21 + 22 * 23 + 24 * 25 + 26 * 27 * 28 * 29 * 30 * 31 * 32 *'.split()))
    print(build('2 3 4 * 5 / 6 * 7 + 8 * 9 + 10 * 11 + 12 * 13 + 14 * 15 + 16 * 17 + 18 * 1
