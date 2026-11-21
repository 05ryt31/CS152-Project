import { readFileSync } from 'node:fs';
import { stdout } from 'node:process';

function safe(columns, row, col) {
    for (let prevRow = 0; prevRow < row; prevRow++) {
        const prevCol = columns[prevRow];
        if (prevCol === col || Math.abs(prevCol - col) === row - prevRow) {
            return false;
        }
    }
    return true;
}

function count(n, row, columns) {
    if (row === n) {
        return 1;
    }
    let total = 0;
    for (let col = 0; col < n; col++) {
        if (safe(columns, row, col)) {
            columns[row] = col;
            total += count(n, row + 1, columns);
        }
    }
    return total;
}

function main() {
    const input = readFileSync(0, 'utf8').trim();
    const n = parseInt(input, 10);
    stdout.write(`${count(n, 0, Array(n).fill(0))}\n`);
}

main();
