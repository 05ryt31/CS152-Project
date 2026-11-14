import fs from 'node:fs';

const lines = fs.readFileSync(0, 'utf8').split('\n')
const n = Number(lines[0]);

let balance = 0
const output = [];
for (let i = 0; i < n; i++) { 
    const [command, amount] = lines[i + 1].split(/\s+/); 
    const value = Number(amount); 
    if (command === 'deposit') balance += value; 
    else if (command === 'withdraw' && value > balance) output.push('error'); 
    else if (command === 'withdraw') balance -= value; 
    else output.push(String(balance)); 
}

if (output.length) console.log(output.join('\n'));
