import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let n;

rl.question('', (input) => {
    n = parseInt(input.trim());
    const result = count(n, 0, []);
    console.log(result);
    process.exit(0);
});

function safe(cols, col) {
    return cols.every((c, i) => c !== col && Math.abs(c - col) !== i + 1);
}

function count(n, row, cols) {
    if (row === n) {
        return 1;
    }
    let total = 0;
    for (let col = 0; col < n; col++) {
        if (safe(cols, col)) {
            total += count(n, row + 1, [...cols, col]);
        }
    }
    return total;
}
