import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let inputLines = [];

rl.on('line', (line) => {
  inputLines.push(line);
});

rl.on('close', () => {
  const line = inputLines.join('\n');
  const tokens = line.split(/\s+/);
  const tree = build(tokens, []);
  const text = render(tree);
  console.log(text);
  process.exit(0);
});

function build(tokens, stack) {
  if (tokens.length === 0) return stack;
  const token = tokens.shift();
  if (['+', '-', '*'].includes(token)) {
    return build(tokens, [new Op(token, stack[0], stack[1]), ...stack.slice(2)]);
  }
  return build(tokens, [new Leaf(token), ...stack]);
}

class Op {
  constructor(op, left, right) {
    this.op = op;
    this.left = left;
    this.right = right;
  }

  toString() {
    return `(${this.left} ${this.op} ${this.right})`;
  }
}

class Leaf {
  constructor(value) {
    this.value = value;
  }

  toString() {
    return this.value;
  }
}

function render(node) {
  if (node instanceof Leaf) return node.toString();
  return node.toString();
}
