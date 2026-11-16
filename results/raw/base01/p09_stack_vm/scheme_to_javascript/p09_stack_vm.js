import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.on('line', (input) => {
  const n = parseInt(input);
  const stackVM = (n) => {
    let i = 0;
    let stack = [];
    while (i < n) {
      const parts = input.split('\n')[i].split(' ');
      const op = parts[0];
      if (op === 'push') {
        stack.unshift(parseInt(parts[1]));
      } else if (op === 'pop') {
        if (stack.length === 0) {
          console.log('error');
        } else {
          stack.shift();
        }
      } else if (op === 'add' || op === 'mul') {
        if (stack.length < 2) {
          console.log('error');
        } else {
          const a = stack.shift();
          const b = stack.shift();
          if (op === 'add') {
            stack.unshift(a + b);
          } else {
            stack.unshift(a * b);
          }
        }
      } else if (op === 'dup') {
        if (stack.length === 0) {
          console.log('error');
        } else {
          stack.unshift(stack[0]);
        }
      } else if (op === 'swap') {
        if (stack.length < 2) {
          console.log('error');
        } else {
          [stack[0], stack[1]] = [stack[1], stack[0]];
        }
      } else {
        if (stack.length === 0) {
          console.log('error');
        } else {
          console.log(stack[0]);
        }
      }
      i++;
    }
  };
  stackVM(n);
});
