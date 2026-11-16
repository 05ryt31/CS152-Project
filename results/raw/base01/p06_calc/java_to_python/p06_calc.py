import sys

class Parser:
    def __init__(self, text):
        self.tokens = [token for token in re.findall(r'\d+|\S', text)]
        self.pos = 0

    def peek(self):
        return self.tokens[self.pos] if self.pos < len(self.tokens) else None

    def next(self):
        token = self.tokens[self.pos]
        self.pos += 1
        return token

    def expression(self):
        value = self.term()
        while self.peek() in ('+', '-'):
            op = self.next()
            right = self.term()
            value += right if op == '+' else -right
        return value

    def term(self):
        value = self.factor()
        while self.peek() == '*':
            self.next()
            value *= self.factor()
        return value

    def factor(self):
        token = self.next()
        if token == '(':
            value = self.expression()
            self.next()
            return value
        return int(token)

def main():
    import re
    text = sys.stdin.read().strip()
    print(Parser(text).expression())

if __name__ == "__main__":
    main()
