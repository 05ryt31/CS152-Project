import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let n;
rl.question('', (inputN) => {
    n = parseInt(inputN.trim(), 10);
    let linesRead = 0;
    const results = [];

    const checkBalanced = (text) => {
        const stack = [];
        for (const char of text) {
            if ("([{".includes(char)) {
                stack.push(char);
            } else if ("]})".includes(char)) {
                if (stack.length === 0 || !matching(stack.pop(), char)) {
                    return "no";
                }
            }
        }
        return stack.length === 0 ? "yes" : "no";
    };

    const matching = (open, close) => {
        return open === '(' && close === ')' ||
               open === '[' && close === ']' ||
               open === '{' && close === '}';
    };

    rl.on('line', (line) => {
        results.push(checkBalanced(line));
        linesRead++;
        if (linesRead === n) {
            results.forEach(result => console.log(result));
            process.exit(0);
        }
    });
});
