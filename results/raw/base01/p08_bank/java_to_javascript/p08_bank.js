import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let n;
let balance = 0;

rl.on('line', (input) => {
  if (!n) {
    n = parseInt(input.trim(), 10);
  } else {
    const [command, amount] = input.split(/\s+/);
    if (command === 'deposit') {
      balance += parseInt(amount, 10);
    } else if (command === 'withdraw') {
      const withdrawAmount = parseInt(amount, 10);
      if (withdrawAmount > balance) {
        console.log('error');
      } else {
        balance -= withdrawAmount;
      }
    } else if (command === 'balance') {
      console.log(balance);
    }
  }
}).on('close', () => {
  process.exit(0);
});
