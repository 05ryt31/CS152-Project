import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

rl.question('', (input) => {
    const tree = buildTree(input);
    console.log(render(tree));
    process.exit(0);
});

function buildTree(line) {
    return foldl(step, [], words(line))[0];
}

function step(stack, token) {
    if (token === '+' || token === '-' || token === '*') {
        const right = stack.shift();
        const left = stack.shift();
        stack.unshift(Op(token, left, right));
    } else {
        stack.unshift(Leaf(token));
    }
    return stack;
}

function render(tree) {
    if (tree.type === 'Leaf') {
        return tree.value;
    } else {
        return '(' + render(tree.left) + ' ' + tree.op + ' ' + render(tree.right) + ')';
    }
}

function foldl(f, acc, xs) {
    for (let i = 0; i < xs.length; i++) {
        acc = f(acc, xs[i]);
    }
    return acc;
}

function words(str) {
    return str.split(/\s+/);
}

class Leaf {
    constructor(value) {
        this.type = 'Leaf';
        this.value = value;
    }
}

class Op {
    constructor(op, left, right) {
        this.type = 'Op';
        this.op = op;
        this.left = left;
        this.right = right;
    }
}
