import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let input = '';

rl.on('line', (line) => {
  input += line.trim() + '\n';
});

rl.on('close', () => {
  const tokens = input.split(/\s+/);
  const stack = [];

  for (const token of tokens) {
    if ('+-*'.includes(token)) {
      const right = stack.pop();
      const left = stack.pop();
      stack.push({ token, left, right });
    } else {
      stack.push({ token });
    }
  }

  function render(node) {
    if (!node.left && !node.right) return node.token;
    return `(${render(node.left)} ${node.token} ${render(node.right)})`;
  }

  console.log(render(stack.pop()));
});
