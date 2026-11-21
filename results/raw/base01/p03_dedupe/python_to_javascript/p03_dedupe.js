import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let line = '';
rl.on('line', (input) => {
  line += input;
});

rl.on('close', () => {
  const tokens = line.split();
  const seen = new Set();
  const unique = [];

  for (const token of tokens) {
    const value = parseInt(token, 10);
    if (!seen.has(value)) {
      seen.add(value);
      unique.push(value);
    }
  }

  if (unique.length > 0) {
    console.log(unique.join(' '));
  }
});
