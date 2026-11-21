import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.on('line', (line) => {
  const numbers = line.split('').map(Number);
  const deduped = Array.from(new Set(numbers));
  console.log(deduped.join(' '));
});
