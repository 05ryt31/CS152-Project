import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.on('line', (input) => {
  const tokens = tokenize(input);
  const parser = new Parser(tokens);
  console.log(parser.expression());
});

function tokenize(text) {
  const tokens = [];
  let i = 0;
  while (i < text.length) {
    const ch = text[i];
    if (ch === ' ') {
      i++;
    } else if (/\d/.test(ch)) {
      let j = i;
      while (j < text.length && /\d/.test(text[j])) {
        j++;
      }
      tokens.push(text.slice(i, j));
      i = j;
    } else {
      tokens.push(ch);
      i++;
    }
  }
  return tokens;
}

class Parser {
  constructor(tokens) {
    this.tokens = tokens;
    this.pos = 0;
  }

  peek() {
    if (this.pos < this.tokens.length) {
      return this.tokens[this.pos];
    }
    return null;
  }

  next() {
    const token = this.tokens[this.pos];
    this.pos++;
    return token;
  }

  expression() {
    let value = this.term();
    while (['+', '-'].includes(this.peek())) {
      const op = this.next();
      const right = this.term();
      if (op === '+') {
        value += right;
      } else {
        value -= right;
      }
    }
    return value;
  }

  term() {
    let value = this.factor();
    while (this.peek() === '*') {
      this.next();
      value *= this.factor();
    }
    return value;
  }

  factor() {
    const token = this.next();
    if (token === '(') {
      const value = this.expression();
      this.next();
      return value;
    }
    return parseInt(token, 10);
  }
}
