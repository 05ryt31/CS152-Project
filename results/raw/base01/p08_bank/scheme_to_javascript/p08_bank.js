import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.on('line', (input) => {
  const n = parseInt(input);
  let balance = 0;

  function loop(i) {
    if (i === n) return;
    const [command, ...parts] = input.split(/\s+/);
    const amount = parseInt(parts[0]);

    switch (command) {
      case 'deposit':
        balance += amount;
        break;
      case 'withdraw':
        if (amount > balance) {
          console.log('error');
        } else {
          balance -= amount;
        }
        break;
      default:
        console.log(balance);
        break;
    }

    loop(i + 1);
  }

  loop(0);
});
