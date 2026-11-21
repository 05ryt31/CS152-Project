import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let text = '';
rl.on('line', (line) => {
  text += line;
}).on('close', () => {
  let result = '';
  let i = 0;

  while (i < text.length) {
    let j = i;
    while (j < text.length && text[j] === text[i]) j++;
    result += text[i] + (j - i);
    i = j;
  }

  console.log(result);
});
