import fs from 'node:fs';

function render(node) { 
    if (!node.left && !node.right) {
        return node.token;
    }
    return `(${render(node.left)} ${node.token} ${render(node.right)})`; 
}

const tokens = (fs.readFileSync(0, 'utf8').split('\n')[0] || '').trim().split(/\s+/).filter(Boolean);
const stack = [];

for (const token of tokens) {
    if ('+-*'.includes(token)) { 
        const right = stack.pop()
        const left = stack.pop(); 
        stack.push({ token, left, right }); 
    } else {
        stack.push({ token });
    }
}

console.log(render(stack[0]));
