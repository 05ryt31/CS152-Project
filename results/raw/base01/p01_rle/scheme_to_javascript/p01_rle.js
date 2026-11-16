import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.question('', (line) => {
  const encode = (chars) => {
    if (chars.length === 0) return '';
    let rest = chars.slice(1);
    let current = chars[0];
    let count = 1;
    let out = '';
    while (rest.length > 0) {
      if (rest[0] === current) {
        count++;
        rest = rest.slice(1);
      } else {
        out += current + count.toString();
        current = rest[0];
        count = 1;
        rest = rest.slice(1);
      }
    }
    out += current + count.toString();
    return out;
  };

  console.log(encode(line.split('')));
});
