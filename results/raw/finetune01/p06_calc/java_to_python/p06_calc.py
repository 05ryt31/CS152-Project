def calc(expression):
    def evaluate(tokens):
        stack = []
        for token in tokens:
            if isinstance(token, int):
                stack.append(token)
            elif token == '+':
                stack.append(stack.pop() + stack.pop())
            elif token == '-':
                b = stack.pop()
                stack.append(stack.pop() - b)
            elif token == '*':
                stack.append(stack.pop() * stack.pop())
        return stack[0]
 
    def tokenize(expression):
        tokens = []
        i = 0
        while i < len(expression):
            if expression[i] == ' ':
                i += 1
            elif expression[i].isdigit():
                start = i
                while i < len(expression) and expression[i].isdigit():
                    i += 1
                tokens.append(int(expression[start:i]))
            elif expression[i] in '+-*()':
                tokens.append(expression[i])
                i += 1
            else:
                raise ValueError('Unknown character')
        return tokens
 
    def parse(tokens):
        def parse_expression():
            left = parse_term()
            while tokens and tokens[-1] in ('+', '-'):
                operator = tokens.pop()
                right = parse_term()
                if operator == '+':
                    left += right
                elif operator == '-':
                    left -= right
            return left
 
        def parse_term():
            left = parse_factor()
            while tokens and tokens[-1] == '*':
                tokens.pop()
                right = parse_factor()
                left *= right
            return left
 
        def parse_factor():
            if tokens[0] == '(':
                tokens.pop(0)
                result = parse_expression()
                if tokens[0] != ')':
                    raise ValueError('Expected )')
                tokens.pop(0)
                return result
            else:
                return tokens.pop(0)
 
        return parse_expression()
 
    return parse(parse(tokenize(expression)))
 
if __name__ == '__main__':
    import sys
    print(calc(sys.argv[1]))
