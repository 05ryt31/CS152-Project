import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let a = [];
let b = [];

rl.on('line', (line) => {
  if (!a.length) {
    a = parse(line);
  } else {
    b = parse(line);
    mergeAndPrint(a, b);
    rl.close();
  }
});

function parse(line) {
  if (line === null || line.trim() === '') return [];

  const parts = line.trim().split(/\s+/);
  const values = parts.map(Number);

  return values;
}

function mergeAndPrint(a, b) {
  let result = '';
  let i = 0;
  let j = 0;

  while (i < a.length && j < b.length) {
    if (result !== '') result += ' ';

    if (a[i] <= b[j]) {
      result += a[i];
      i++;
    } else {
      result += b[j];
      j++;
    }
  }

  while (i < a.length) {
    if (result !== '') result += ' ';
    result += a[i];
    i++;
  }

  while (j < b.length) {
    if (result !== '') result += ' ';
    result += b[j];
    j++;
  }

  console.log(result);
}
