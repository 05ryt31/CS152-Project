import fs from 'node:fs';

function touch(key) { 
    const item = values.get(key); 
    if (item) {
        values.delete(key);
        values.set(key, item);
    }
}

const lines = fs.readFileSync(0, 'utf8').split('\n');
const capacity = Number(lines[0]);
const n = Number(lines[1]);

const values = new Map();
const output = [];
for (let i = 0; i < n; i++) { 
    const parts = lines[i + 2].split(/\s+/);
    const key = Number(parts[1]);
    if (parts[0] === 'get') { 
        if (values.has(key)) { 
            output.push(String(values.get(key))); 
            touch(key); 
        } else output.push('-1'); 
    } else { 
        if (values.has(key)) touch(key); 
        else if (values.size === capacity) values.delete(values.keys().next().value); 
        values.set(key, Number(parts[2])); 
    }
}

if (output.length) console.log(output.join('\n'));
