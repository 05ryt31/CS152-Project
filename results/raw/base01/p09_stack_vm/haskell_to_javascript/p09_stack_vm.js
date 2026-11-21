import { createInterface } from 'node:readline';

const rl = createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

let lines = [];
rl.on('line', (line) => {
    lines.push(line);
});

rl.on('close', () => {
    const n = parseInt(lines[0]);
    const commands = lines.slice(1);
    const result = runStack(commands);
    console.log(result.join('\n'));
});

function runStack(commands) {
    return commands.map(command => {
        const [op, ...args] = command.split(' ');
        switch (op) {
            case 'push':
                return push(parseInt(args[0]));
            case 'pop':
                return pop();
            case 'add':
                return add();
            case 'mul':
                return mul();
            case 'dup':
                return dup();
            case 'swap':
                return swap();
            case 'print':
                return print();
            default:
                return null;
        }
    }).filter(output => output !== null);
}

function push(x) {
    stack.push(x);
    return null;
}

function pop() {
    if (stack.length === 0) {
        return 'error';
    }
    stack.pop();
    return null;
}

function add() {
    if (stack.length < 2) {
        return 'error';
    }
    const b = stack.pop();
    const a = stack.pop();
    stack.push(a + b);
    return null;
}

function mul() {
    if (stack.length < 2) {
        return 'error';
    }
    const b = stack.pop();
    const a = stack.pop();
    stack.push(a * b);
    return null;
}

function dup() {
    if (stack.length === 0) {
        return 'error';
    }
    stack.push(stack[stack.length - 1]);
    return null;
}

function swap() {
    if (stack.length < 2) {
        return 'error';
    }
    const b = stack.pop();
    const a = stack.pop();
    stack.push(b, a);
    return null;
}

function print() {
    if (stack.length === 0) {
        return 'error';
    }
    return stack[stack.length - 1].toString();
}

const stack = [];
