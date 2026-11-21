import sys

def factor():
    global position
    token = tokens[position]
    position += 1
    if token == '(':
        value = expression()
        position += 1
        return value
    return int(token)

def term():
    global position
    value = factor()
    while tokens[position] == '*':
        position += 1
        value *= factor()
    return value

def expression():
    global position
    value = term()
    while tokens[position] in '+-':
        op = tokens[position]
        position += 1
        right = term()
        value = value + right if op == '+' else value - right
    return value

line = sys.stdin.read().strip()
tokens = re.findall(r'\d+|[()+*-]', line)
position = 0

print(expression())
