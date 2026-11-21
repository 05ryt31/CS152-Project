import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

rl.on('line', (line) => {
    const result = line.split('').reduce((acc, char, index, array) => {
        if (index === 0 || char !== array[index - 1]) {
            acc.push(char + (array.slice(index).filter(c => c === char).length));
        }
        return acc;
    }, []).join('');
    console.log(result);
});
