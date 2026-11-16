import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.on('line', (input) => {
  const tokens = input.split(/\s+/);
  const build = (tokens) => {
    let stack = [];
    while (tokens.length > 0) {
      const token = tokens.shift();
      if (['+', '-', '*'].includes(token)) {
        const right = stack.pop();
        const left = stack.pop();
        stack.push([token, left, right]);
      } else {
        stack.push(token);
      }
    }
    return stack[0];
  };

  const render = (tree) => {
    if (typeof tree === 'string') {
      return tree;
    }
    return `(${render(tree[1])} ${tree[0]} ${render(tree[2])})`;
  };

  console.log(render(build(tokens)));
});
