import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let lines = [];
rl.on('line', (line) => {
  lines.push(line);
});

rl.on('close', () => {
  const nLine = lines.shift();
  const n = parseInt(nLine, 10);
  run(n);
  process.exit(0);
});

function run(n) {
  if (n === 0) return;
  const line = lines.shift();
  if (balanced(line)) {
    console.log('yes');
  } else {
    console.log('no');
  }
  run(n - 1);
}

function balanced(line) {
  const chars = Array.from(line);
  return balancedChars(chars, []);
}

function balancedChars(chars, stack) {
  if (chars.length === 0) return stack.length === 0;
  const [c, ...cs] = chars;
  if (['(', '[', '{'].includes(c)) {
    return balancedChars(cs, [c, ...stack]);
  } else {
    const open = stack[0];
    if (matching(open, c)) {
      return balancedChars(cs, stack.slice(1));
    } else {
      return false;
    }
  }
}

function matching(open, close) {
  return open === '(' && close === ')' ||
         open === '[' && close === ']' ||
         open === '{' && close === '}';
}
