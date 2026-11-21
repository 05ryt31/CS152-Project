import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let values = '';
let k = null;
let stages = [];

rl.on('line', (input) => {
    if (values === '') {
        values = input;
    } else if (k === null) {
        k = parseInt(input);
    } else {
        stages.push(input);
    }
}).on('close', () => {
    const result = stages.reduce((xs, stage) => apply(xs, stage.split(' ')), readNums(values));
    if (result.length === 0 && k > 0 && stages[stages.length - 1].startsWith('reduce')) {
        console.log('none');
    } else if (result.length > 0) {
        console.log(result.map(String).join(' '));
    }
});

function apply(xs, stage) {
    const [cmd, type, ...args] = stage;
    switch (cmd) {
        case 'map':
            return args[0] === 'add' ? xs.map(x => x + parseInt(args[1])) : xs.map(x => x * parseInt(args[1]));
        case 'filter':
            return type === 'even' ? xs.filter(x => x % 2 === 0) : type === 'odd' ? xs.filter(x => x % 2 !== 0) : xs.filter(x => x > parseInt(args[0]));
        case 'reduce':
            return type === 'sum' ? [xs.reduce((a, b) => a + b, 0)] : type === 'max' ? [Math.max(...xs)] : [];
        default:
            return xs;
    }
}

function readNums(s) {
    return s.split(' ').map(Number);
}
