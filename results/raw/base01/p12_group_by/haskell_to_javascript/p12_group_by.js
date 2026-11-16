import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let lines = [];
rl.on('line', (line) => {
    lines.push(line);
});

rl.on('close', () => {
    const n = parseInt(lines.shift(), 10);
    const rows = lines.slice(0, n);
    const processedRows = processRows(rows);
    processedRows.forEach(row => console.log(row));
    process.exit(0);
});

function processRows(rows) {
    const grouped = rows.reduce((groups, line) => {
        const [key, value] = line.split(' ');
        const v = parseInt(value, 10);
        if (!groups[key]) {
            groups[key] = [0, 0];
        }
        groups[key][0] += v;
        groups[key][1]++;
        return groups;
    }, {});

    return Object.entries(grouped).map(([key, [sum, count]]) => `${key} ${sum} ${count}`);
}
