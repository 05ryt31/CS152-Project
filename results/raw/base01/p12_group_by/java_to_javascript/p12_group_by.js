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
  const n = parseInt(lines.shift());
  const groups = new Map();

  for (let i = 0; i < n; i++) {
    const [key, value] = lines[i].split(/\s+/);
    if (!groups.has(key)) {
      groups.set(key, [0, 0]);
    }
    groups.get(key)[0] += parseInt(value);
    groups.get(key)[1]++;
  }

  groups.forEach((value, key) => {
    console.log(`${key} ${value[0]} ${value[1]}`);
  });
});
