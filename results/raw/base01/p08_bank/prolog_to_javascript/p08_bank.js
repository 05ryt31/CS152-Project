import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let balance = 0;

async function main() {
  const nLine = await readline();
  const n = parseInt(nLine);
  await processCommands(n, 0);
}

function processCommands(n, balance) {
  if (n === 0) return;
  return new Promise((resolve) => {
    rl.question('', async (line) => {
      const parts = line.split(' ');
      const [cmd, amount] = parts;
      let newBalance = balance;
      switch (cmd) {
        case 'deposit':
          newBalance += parseInt(amount);
          break;
        case 'withdraw':
          const value = parseInt(amount);
          if (value > balance) {
            console.error('error');
          } else {
            newBalance -= value;
          }
          break;
        case 'balance':
          console.log(balance);
          break;
      }
      resolve(processCommands(n - 1, newBalance));
    });
  });
}

main().then(() => process.exit(0));
