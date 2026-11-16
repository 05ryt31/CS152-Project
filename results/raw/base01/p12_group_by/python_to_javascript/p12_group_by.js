import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let n;
let sums = {};
let counts = {};

rl.on('line', (line) => {
  if (!n) {
    n = parseInt(line);
  } else {
    const [key, value] = line.split();
    sums[key] = (sums[key] || 0) + parseInt(value);
    counts[key] = (counts[key] || 0) + 1;
  }
}).on('close', () => {
  Object.keys(sums).sort().forEach(key => {
    console.log(`${key} ${sums[key]} ${counts[key]}`);
  });
  process.exit(0);
});
