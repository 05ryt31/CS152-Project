import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
});

rl.question('', (input) => {
  const parser = new Parser(input);
  console.log(parser.expression());
  rl.close();
});

class Parser {
  constructor(text) {
    this.tokens = [];
    let pos = 0;
    for (let i = 0; i < text.length;) {
      const c = text[i];
      if (/\s/.test(c)) i++;
      else if (/d/.test(c)) {
        let j = i;
        while (j < text.length && /\d/.test(text[j])) j++;
        this.tokens.push(text.substring(i, j));
        i = j;
      } else {
        this.tokens.push(c);
        i++;
      }
    }
  }

  peek() {
    return this.pos < this.tokens.length ? this.tokens[this.pos] : null;
  }

  next() {
    const token = this.tokens[this.pos];
    this.pos++;
    return token;
  }

  expression() {
    let value = this.term();
    while (this.peek() === '+' || this.peek() === '-') {
      const op = this.next();
      const right = this.term();
      value = op === '+' ? value + right : value - right;
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
