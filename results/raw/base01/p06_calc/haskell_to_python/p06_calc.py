import sys

def tokens(s):
    result = []
    i = 0
    while i < len(s):
        if s[i] == ' ':
            i += 1
        elif s[i] in "+-*()":
            result.append(s[i])
            i += 1
        else:
            j = i
            while j < len(s) and s[j].isdigit():
                j += 1
            result.append(s[i:j])
            i = j
    return result

def parse_expression(tokens):
    x, rest = parse_term(tokens)
    return parse_adds(x, rest)

def parse_adds(x, tokens):
    if not tokens:
        return x, tokens
    op = tokens[0]
    if op == '+' or op == '-':
        y, rest = parse_term(tokens[1:])
        if op == '+':
            return parse_adds(x + y, rest)
        else:
            return parse_adds(x - y, rest)
    return x, tokens

def parse_term(tokens):
    x, rest = parse_factor(tokens)
    return parse_muls(x, rest)

def parse_muls(x, tokens):
    if not tokens or tokens[0] != '*':
        return x, tokens
    y, rest = parse_factor(tokens[1:])
    return parse_muls(x * y, rest)

def parse_factor(tokens):
    if tokens[0] == '(':
        x, rest = parse_expression(tokens[1:])
        return x, rest[1:]
    else:
        return int(tokens[0]), tokens[1:]

def main():
    line = sys.stdin.read().strip()
    result = parse_expression(tokens(line))
    print(result)

if __name__ == "__main__":
    main()
