import fs from 'node:fs';

const lines = fs.readFileSync(0, 'utf8').split('\n');
const n = Number(lines[0]);

const groups = new Map();
for (let i = 0; i < n; i++) { 
    const [key, raw] = lines[i + 1].split(/\s+/);
    const value = Number(raw); 
    const group = groups.get(key) || [0, 0]; 
    groups.set(key, [group[0] + value, group[1] + 1]); 
}

for (const key of [...groups.keys()].sort()) console.log(key, ...groups.get(key));
