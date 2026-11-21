import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let n;
rl.on('line', (input) => {
  if (!n) {
    n = parseInt(input);
  } else {
    const parts = input.split();
    const op = parts[0];
    let stack = [];
    switch (op) {
      case 'push':
        stack.push(parseInt(parts[1]));
        break;
      case 'pop':
        if (stack.length < 1) {
          console.error('error');
        } else {
          stack.pop();
        }
        break;
      case 'add':
      case 'mul':
        if (stack.length < 2) {
          console.error('error');
        } else {
          const b = stack.pop();
          const a = stack.pop();
          if (op === 'add') {
            stack.push(a + b);
          } else {
            stack.push(a * b);
          }
        }
        break;
      case 'dup':
        if (stack.length < 1) {
          console.error('error');
        } else {
          stack.push(stack[stack.length - 1]);
        }
        break;
      case 'swap':
        if (stack.length < 2) {
          console.error('error');
        } else {
          [stack[stack.length - 1], stack[stack.length - 2]] = [stack[stack.length - 2], stack[stack.length - 1]];
        }
        break;
      case 'print':
        if (stack.length < 1) {
          console.error('error');
        } else {
          console.log(stack[stack.length - 1]);
        }
        break;
    }
  }
}).on('close', () => {
  process.exit(0);
});
