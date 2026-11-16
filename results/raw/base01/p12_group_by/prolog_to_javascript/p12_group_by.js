import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let lines = [];
rl.on('line', (line) => {
  lines.push(line);
});

rl.on('close', () => {
  const n = parseInt(lines[0]);
  const groups = {};
  for (let i = 1; i <= n; i++) {
    const [key, value] = lines[i].split(' ');
    const v = parseInt(value);
    if (!groups[key]) {
      groups[key] = { sum: v, count: 1 };
    } else {
      groups[key].sum += v;
      groups[key].count++;
    }
  }

  const sortedKeys = Object.keys(groups).sort();
  sortedKeys.forEach(key => {
    console.log(`${key} ${groups[key].sum} ${groups[key].count}`);
  });
});
