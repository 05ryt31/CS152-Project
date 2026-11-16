import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

function numbers(line) {
  if (line === '') return [];
  return line.split(' ').map(Number);
}

function merge(a, b) {
  if (a.length === 0) return b;
  if (b.length === 0) return a;
  if (a[0] <= b[0]) return [a[0], ...merge(a.slice(1), b)];
  return [b[0], ...merge(a, b.slice(1))];
}

function printList(values) {
  if (values.length > 0) {
    process.stdout.write(`${values[0]}`);
    for (let i = 1; i < values.length; i++) {
      process.stdout.write(` ${values[i]}`);
    }
    process.stdout.write('\n');
  }
}

async function main() {
  const line1 = await new Promise(resolve => rl.question('', resolve));
  const line2 = await new Promise(resolve => rl.question('', resolve));
  rl.close();
  printList(merge(numbers(line1), numbers(line2)));
}

main();
