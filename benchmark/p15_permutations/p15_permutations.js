import fs from 'node:fs';

function generate(prefix, remaining) { 
    if (!remaining.length) output.push(prefix.join('')); 
    else {
        for (let i = 0; i < remaining.length; i++) {
            generate([...prefix, remaining[i]], [...remaining.slice(0, i), ...remaining.slice(i + 1)]); 
        }
    }
}

const letters = [...fs.readFileSync(0, 'utf8').trim()].sort()
const output = [];
generate([], letters); 
console.log(output.join('\n'));
