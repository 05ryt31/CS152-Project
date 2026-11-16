import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let line = '';
rl.on('line', (input) => {
  line += input + '\n';
}).on('close', () => {
  const tokens = line.trim().split(/\s+/);
  const seen = new Set();
  let result = '';

  for (const token of tokens) {
    if (token === '') continue;

    const value = parseInt(token, 10);
    if (seen.add(value)) {
      if (result !== '') result += ' ';
      result += value;
    }
  }

  if (result !== '') console.log(result);
});
