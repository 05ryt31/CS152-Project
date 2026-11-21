import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let n;
rl.on('line', (input) => {
    if (!n) {
        n = parseInt(input);
    } else {
        const result = balanced(input) ? 'yes' : 'no';
        console.log(result);
        n--;
        if (n === 0) {
            rl.close();
        }
    }
});

function matching(opener, closer) {
    return (opener === '(' && closer === ')') ||
           (opener === '[' && closer === ']') ||
           (opener === '{' && closer === '}');
}

function balanced(text) {
    let stack = [];
    for (let char of text) {
        if ('([{'.includes(char)) {
            stack.push(char);
        } else if (']})'.includes(char)) {
            if (stack.length === 0 || !matching(stack.pop(), char)) {
                return false;
            }
        }
    }
    return stack.length === 0;
}
