import { readFileSync } from 'node:fs';
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
  const a = lines.length > 0 ? lines[0].split(' ').map(Number) : [];
  const b = lines.length > 1 ? lines[1].split(' ').map(Number) : [];
  let merged = [];
  let i = 0;
  let j = 0;
  while (i < a.length && j < b.length) {
    if (a[i] <= b[j]) {
      merged.push(a[i]);
      i++;
    } else {
      merged.push(b[j]);
      j++;
    }
  }
  while (i < a.length) {
    merged.push(a[i]);
    i++;
  }
  while (j < b.length) {
    merged.push(b[j]);
    j++;
  }
  if (merged.length > 0) {
    console.log(merged.join(' '));
  }
});
