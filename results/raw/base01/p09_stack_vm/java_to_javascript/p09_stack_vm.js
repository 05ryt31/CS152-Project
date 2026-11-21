import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let n;
rl.on('line', (line) => {
  if (!n) {
    n = parseInt(line);
  } else {
    const [op, ...args] = line.split(/\s+/);
    handleOperation(op, args.map(Number));
  }
}).on('close', () => {
  process.exit(0);
});

const stack = [];

function handleOperation(op, args) {
  switch (op) {
    case 'push':
      stack.push(args[0]);
      break;
    case 'pop':
      if (stack.length === 0) console.log('error');
      else stack.pop();
      break;
    case 'add':
    case 'mul':
      if (stack.length < 2) console.log('error');
      else {
        const b = stack.pop();
        const a = stack.pop();
        stack.push(op === 'add' ? a + b : a * b);
      }
      break;
    case 'dup':
      if (stack.length === 0) console.log('error');
      else stack.push(stack[stack.length - 1]);
      break;
    case 'swap':
      if (stack.length < 2) console.log('error');
      else {
        const a = stack.pop();
        const b = stack.pop();
        stack.push(a);
        stack.push(b);
      }
      break;
    case 'print':
      if (stack.length === 0) console.log('error');
      else console.log(stack[stack.length - 1]);
      break;
  }
}
