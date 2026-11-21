import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let input = '';

rl.on('line', (line) => {
  input += line;
});

rl.on('close', () => {
  const chars = input.split('');
  const encoded = encode(chars);
  console.log(encoded);
  process.exit(0);
});

function encode(chars) {
  if (chars.length === 0) return [];
  const [C, ...Cs] = chars;
  const [Rest, Count] = run(C, Cs, 1);
  const Ns = Count.toString();
  return [[C, ...Ns], ...encode(Rest)];
}

function run(C, Cs, N) {
  if (Cs.length === 0 || Cs[0] !== C) return [Cs, N];
  return run(C, Cs.slice(1), N + 1);
}
