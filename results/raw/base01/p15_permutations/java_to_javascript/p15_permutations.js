import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.question('', (input) => {
  const letters = input.split('');
  letters.sort();
  generate(letters, new Array(letters.length).fill(false), '');
  rl.close();
});

function generate(letters, used, current) {
  if (current.length === letters.length) { 
    console.log(current); 
    return; 
  }

  for (let i = 0; i < letters.length; i++) {
    if (!used[i]) {
      used[i] = true; 
      generate(letters, used, current + letters[i]);
      used[i] = false;
    }
  }
}
