import fs from 'node:fs';

const pairs = { ')': '(', ']': '[', '}': '{' };

function balanced(text) { 
    const stack = []; 
    for (const ch of text) { 
        if ('([{'.includes(ch)) stack.push(ch); 
        else if (!stack.length || stack.pop() !== pairs[ch]) return false; 
    }
    return !stack.length; 
}

const lines = fs.readFileSync(0, 'utf8').split('\n');
const n = Number(lines[0]);
for (let i = 0; i < n; i++) console.log(balanced(lines[i + 1] || '') ? 'yes' : 'no');
