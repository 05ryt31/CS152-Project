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
  const letters = Array.from(input.trim()).sort();
  generatePermutations('', letters);
});

function removeFirst(value, values) {
  return values.filter(v => v !== value);
}

function generate(prefix, remaining) {
  if (remaining.length === 0) {
    console.log(prefix);
  } else {
    remaining.forEach((letter, index) => {
      generate(prefix + letter, [...removeFirst(letter, remaining)]);
    });
  }
}
