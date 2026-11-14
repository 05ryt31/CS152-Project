import fs from 'node:fs';

const line = fs.readFileSync(0, 'utf8').split('\n')[0];
const seen = new Set()
const result = [];
const trimmed = (line || '').trim();
const tokens = trimmed ? line.trim().split(/\s+/) : [];

for (const token of tokens) {
    const value = Number(token);
    if (!seen.has(value)) { 
        seen.add(value); 
        result.push(value); 
    }
}

if (result.length) console.log(result.join(' '));
