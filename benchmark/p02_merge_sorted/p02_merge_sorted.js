import fs from 'node:fs';

function parseLine(line) {
    const trimmed = (line || '').trim();
    return trimmed ? trimmed.split(/\s+/).map(Number) : [];
}

const lines = fs.readFileSync(0, 'utf8').split('\n');
const a = parseLine(lines[0]);
const b = parseLine(lines[1]);
const result = [];
let i = 0;
let j = 0;

while (i < a.length && j < b.length) {
    if (a[i] <= b[j]) {
        result.push(a[i]);
        i++;
    } else {
        result.push(b[j]);
        j++;
    }
}

while (i < a.length) {
    result.push(a[i]);
    i++;
}

while (j < b.length) {
    result.push(b[j]);
    j++;
}

if (result.length) console.log(result.join(' '));
