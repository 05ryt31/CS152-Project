import fs from 'node:fs';

const lines = fs.readFileSync(0, 'utf8').split('\n');
if (lines[lines.length - 1] === '') lines.pop();
for (const line of lines.reverse()) console.log(line);
