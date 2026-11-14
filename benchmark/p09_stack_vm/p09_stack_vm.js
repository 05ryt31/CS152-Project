import fs from 'node:fs';

const lines = fs.readFileSync(0, 'utf8').split('\n');
const n = Number(lines[0]);

const stack = [];
const output = [];
for (let i = 0; i < n; i++) { 
    const parts = lines[i + 1].split(/\s+/);
    const op = parts[0];
    if (op === 'push') stack.push(Number(parts[1]));
    else if (op === 'pop') { 
        if (!stack.length) output.push('error'); 
        else stack.pop(); 
    } else if (op === 'add' || op === 'mul') { 
        if (stack.length < 2) output.push('error'); 
        else { 
            const b = stack.pop();
            const a = stack.pop();
            stack.push(op === 'add' ? a + b : a * b); 
        } 
    } else if (op === 'dup') { 
        if (!stack.length) output.push('error'); 
        else stack.push(stack.at(-1)); 
    } else if (op === 'swap') { 
        if (stack.length < 2) output.push('error'); 
        else { 
            const top = stack.length - 1; 
            [stack[top], stack[top - 1]] = [stack[top - 1], stack[top]]; 
        } 
    } else output.push(stack.length ? String(stack.at(-1)) : 'error');
}

if (output.length) console.log(output.join('\n'));
