import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let lines = [];
rl.on('line', (line) => {
  lines.push(line);
}).on('close', () => {
  const n = parseInt(lines.shift(), 10);
  for (let i = 0; i < n; i++) {
    const line = lines[i];
    console.log(balanced(line) ? 'yes' : 'no');
  }
});

function balanced(text) {
  if (text === null) return true;
  const stack = [];
  for (const c of text) {
    if (c === '(' || c === '[' || c === '{') stack.push(c);
    else {
      if (stack.length === 0 || 
          (c === ')' && stack[stack.length - 1] !== '(') ||
          (c === ']' && stack[stack.length - 1] !== '[') || 
          (c === '}' && stack[stack.length - 1] !== '{')) return false;
      stack.pop();
    }
  }
  return stack.length === 0;
}
