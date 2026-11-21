import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

const PAIRS = {
  ')': '(',
  ']': '[',
  '}': '{'
};

function balanced(text) {
  const stack = [];
  for (const ch of text) {
    if ('([{'.includes(ch)) {
      stack.push(ch);
    } else {
      if (stack.length === 0 || stack[stack.length - 1] !== PAIRS[ch]) {
        return false;
      }
      stack.pop();
    }
  }
  return stack.length === 0;
}

async function main() {
  const n = parseInt(await rl.question(''), 10);
  for (let i = 0; i < n; i++) {
    const line = await rl.question('');
    if (balanced(line)) {
      console.log('yes');
    } else {
      console.log('no');
    }
  }
}

main();
