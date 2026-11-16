import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let line = '';
rl.on('line', (input) => {
  line += input;
}).on('close', () => {
  let result = '';
  let i = 0;
  while (i < line.length) {
    let j = i;
    while (j < line.length && line[j] === line[i]) {
      j++;
    }
    result += line[i] + (j - i);
    i = j;
  }
  console.log(result);
});
