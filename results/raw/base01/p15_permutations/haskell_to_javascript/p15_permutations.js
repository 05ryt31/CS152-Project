import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let input = '';

rl.on('line', (line) => {
    input += line + '\n';
});

rl.on('close', () => {
    const permutations = (arr) => {
        if (arr.length === 0) return [[]];
        return arr.flatMap((_, i) =>
            permutations(arr.slice(0, i).concat(arr.slice(i + 1))).map(pick => [arr[i], ...pick])
        );
    };

    const sortLines = (lines) => lines.sort();

    const result = sortLines(permutations(input.trim().split('\n')));
    console.log(result.join('\n'));
});
