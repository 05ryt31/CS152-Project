import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let balance = 0;
rl.on('line', (input) => {
    const [command, ...args] = input.split();
    switch (command) {
        case 'deposit':
            balance += parseInt(args[0], 10);
            break;
        case 'withdraw':
            const amount = parseInt(args[0], 10);
            if (amount > balance) {
                console.error('error');
            } else {
                balance -= amount;
            }
            break;
        case 'balance':
            console.log(balance);
            break;
    }
});
