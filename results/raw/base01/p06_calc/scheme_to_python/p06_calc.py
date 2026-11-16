import sys

def tokenize(s):
    tokens = []
    i = 0
    while i < len(s):
        if s[i].isspace():
            i += 1
        elif s[i].isdigit():
            num = ''
            while i < len(s) and s[i].isdigit():
                num += s[i]
                i += 1
            tokens.append(int(num))
        else:
            tokens.append(s[i])
            i += 1
    return tokens

def parse_expr(tokens):
    def parse_term(tokens):
        def parse_factor(tokens):
            if isinstance(tokens[0], int):
                return [tokens[0], tokens[1:]]
            else:
                return parse_expr(tokens[1:])
        
        term = parse_factor(tokens)
        while tokens and tokens[0] == '*':
            _, tokens = term
            factor = parse_factor(tokens)
            term = [term[0] * factor[0], factor[1]]
        return term
    
    expr = parse_term(tokens)
    while tokens and tokens[0] in ('+', '-'):
        op, tokens = expr
        if tokens[0] == '+':
            _, tokens = expr
            term = parse_term(tokens)
            expr = [op + term[0], term[1]]
        else:
            _, tokens = expr
            term = parse_term(tokens)
            expr = [op - term[0], term[1]]
    return expr

def calc(s):
    return parse_expr(tokenize(s))[0]

for line in sys.stdin:
    print(calc(line.strip()))
