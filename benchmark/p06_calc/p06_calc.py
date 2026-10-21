import sys


def tokenize(text):
    tokens = []
    i = 0
    while i < len(text):
        ch = text[i]
        if ch == " ":
            i += 1
        elif ch.isdigit():
            j = i
            while j < len(text) and text[j].isdigit():
                j += 1
            tokens.append(text[i:j])
            i = j
        else:
            tokens.append(ch)
            i += 1
    return tokens


class Parser:
    def __init__(self, tokens):
        self.tokens = tokens
        self.pos = 0

    def peek(self):
        if self.pos < len(self.tokens):
            return self.tokens[self.pos]
        return None

    def next(self):
        token = self.tokens[self.pos]
        self.pos += 1
        return token

    def expression(self):
        value = self.term()
        while self.peek() in ("+", "-"):
            op = self.next()
            right = self.term()
            if op == "+":
                value = value + right
            else:
                value = value - right
        return value

    def term(self):
        value = self.factor()
        while self.peek() == "*":
            self.next()
            value = value * self.factor()
        return value

    def factor(self):
        token = self.next()
        if token == "(":
            value = self.expression()
            self.next()
            return value
        return int(token)


def main():
    text = sys.stdin.readline().rstrip("\n")
    parser = Parser(tokenize(text))
    print(parser.expression())


main()
