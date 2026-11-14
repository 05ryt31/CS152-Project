import fs from 'node:fs';

const line = fs.readFileSync(0, 'utf8').split('\n')[0];
let result = '';

for (let i = 0; i < line.length;) {
    let j = i;
    while (j < line.length && line[j] === line[i]) j++;
    result += line[i] + (j - i);
    i = j;
}

console.log(result);
