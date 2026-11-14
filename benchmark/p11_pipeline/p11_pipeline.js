import fs from 'node:fs';

const lines = fs.readFileSync(0, 'utf8').split('\n')
const first = (lines[0] || '').trim();

const values = first ? first.split(/\s+/).map(Number) : [];
const k = Number(lines[1]);
let result = values;
for (let i = 0; i < k; i++) { 
    const p = lines[i + 2].split(/\s+/); 
    if (p[0] === 'map') {
        result = result.map(x => p[1] === 'add' ? x + Number(p[2]) : x * Number(p[2])); 
    } else if (p[0] === 'filter') {
        result = result.filter(x => p[1] === 'even' ? x % 2 === 0 : p[1] === 'odd' ? x % 2 !== 0 : x > Number(p[2])); 
    } else {
        result = p[1] === 'sum' ? result.reduce((a, x) => a + x, 0) : result.length ? Math.max(...result) : 'none'; 
    }
}

if (!Array.isArray(result) || result.length) console.log(Array.isArray(result) ? result.join(' ') : result);
