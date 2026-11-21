import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let lines = [];
rl.on('line', (line) => {
    lines.push(line);
}).on('close', () => {
    const a = lines[0];
    const b = lines[1];
    const result = merge(readNums(a), readNums(b));
    if (result.length > 0) {
        console.log(result.join(' '));
    }
    process.exit(0);
});

function readNums(s) {
    return s.split(' ').map(Number);
}

function merge(xs, ys) {
    if (xs.length === 0) return ys;
    if (ys.length === 0) return xs;
    if (xs[0] <= ys[0]) return [xs[0], ...merge(xs.slice(1), ys)];
    return [ys[0], ...merge(xs, ys.slice(1))];
}
