import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
});

let input = '';

rl.on('line', (line) => {
  input += line + '\n';
});

rl.on('close', () => {
  const tokens = input.trim().split(/\s+/);
  const tree = build(tokens);
  console.log(render(tree));
});

function build(tokens) {
  const stack = [];
  for (const token of tokens) {
    if (token === '+' || token === '-' || token === '*') {
      const right = stack.pop();
      const left = stack.pop();
      stack.push({ token, left, right });
    } else {
      stack.push({ token });
    }
  }
  return stack[0];
}

function render(node) {
  if (!node.left && !node.right) {
    return node.token;
  }
  return '(' + render(node.left) + ' ' + node.token + ' ' + render(node.right) + ')';
}
