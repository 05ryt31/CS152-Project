import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let cap, n;
const commands = [];

rl.on('line', (line) => {
    if (cap === undefined) {
        cap = parseInt(line);
    } else if (n === undefined) {
        n = parseInt(line);
    } else {
        commands.push(line);
    }
}).on('close', () => {
    const result = runLRU(cap, commands);
    console.log(result.join('\n'));
});

function runLRU(cap, commands) {
    const [_, rawOutputs] = mapAccumL(apply, [new Map(), []], commands);
    return rawOutputs.filter(output => output !== null);
}

function apply(state, line) {
    const [values, order] = state;
    const [command, ...args] = line.split(' ');
    switch (command) {
        case 'get':
            const key = parseInt(args[0]);
            if (values.has(key)) {
                const value = values.get(key);
                values.set(key, value);
                return [[...values, ...order.filter(k => k !== key)], `${value}`];
            } else {
                return [state, '-1'];
            }
        case 'put':
            const keyValue = parseInt(args[0]);
            const valueValue = parseInt(args[1]);
            values.set(keyValue, valueValue);
            const newOrder = [...order, keyValue].filter(k => k !== keyValue);
            if (newOrder.length > cap) {
                const oldest = newOrder.shift();
                values.delete(oldest);
            }
            return [values, newOrder];
        default:
            return state;
    }
}
