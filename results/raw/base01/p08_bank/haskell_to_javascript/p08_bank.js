import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let balance = 0;
const commands = [];

rl.on('line', (line) => {
    commands.push(line);
});

rl.on('close', () => {
    const outputs = runCommands(commands);
    outputs.forEach(output => {
        console.log(output);
    });
    process.exit(0);
});

function runCommands(commands) {
    return commands.map(command => {
        const [cmd, amount] = command.split(' ');
        switch (cmd) {
            case 'deposit':
                const amtDeposit = parseInt(amount, 10);
                if (!isNaN(amtDeposit) && amtDeposit >= 0) {
                    balance += amtDeposit;
                    return null;
                }
                break;
            case 'withdraw':
                const amtWithdraw = parseInt(amount, 10);
                if (!isNaN(amtWithdraw) && amtWithdraw >= 0) {
                    if (amtWithdraw > balance) {
                        return 'error';
                    } else {
                        balance -= amtWithdraw;
                        return null;
                    }
                }
                break;
            case 'balance':
                return balance.toString();
            default:
                return null;
        }
        return null;
    }).filter(output => output !== null);
}
