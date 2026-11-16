import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let letters;
rl.on('line', (input) => {
  letters = input.trim().split('').sort();
  rl.close();
}).on('close', () => {
  const results = [];
  function generate(used, current) {
    if (current.length === letters.length) {
      results.push(current.join(''));
      return;
    }
    for (let i = 0; i < letters.length; i++) {
      if (!used[i]) {
        used[i] = true;
        current.push(letters[i]);
        generate(used, current);
        current.pop();
        used[i] = false;
      }
    }
  }

  generate(Array(letters.length).fill(false), []);
  results.forEach(word => console.log(word));
});
