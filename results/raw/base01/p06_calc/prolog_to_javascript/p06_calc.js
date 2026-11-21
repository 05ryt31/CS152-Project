import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let input = '';

rl.on('line', (line) => {
  input += line + '\n';
});

rl.on('close', () => {
  const [Expression] = input.trim().split('\n');
  try {
    const Value = eval(Expression);
    console.log(Value);
    process.exit(0);
  } catch (error) {
    console.error(error.message);
    process.exit(1);
  }
});
