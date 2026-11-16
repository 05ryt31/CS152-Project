import { createInterface } from 'node:readline';
import { stdin, stdout } from 'node:process';

const rl = createInterface({
    input: stdin,
    output: stdout,
    terminal: false
});

let input = '';

rl.on('line', (line) => {
    input += line + '\n';
});

rl.on('close', () => {
    const result = unique(readNums(input));
    if (result.length > 0) {
        console.log(result.join(' '));
    }
    process.exit(0);
});

function readNums(s) {
    return s.trim().split(/\s+/).map(Number);
}

function unique(arr) {
    const seen = new Set();
    return arr.filter(x => {
        if (seen.has(x)) {
            return false;
        } else {
            seen.add(x);
            return true;
        }
    });
}
