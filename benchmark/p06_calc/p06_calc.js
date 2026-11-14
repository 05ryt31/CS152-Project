import fs from 'node:fs';

function factor() { 
    const token = tokens[position]; 
    position++;
    if (token === '(') {
        const value = expression();
        position++;
        return value;
    }
    return Number(token); 
}

function term() { 
    let value = factor(); 
    while (tokens[position] === '*') { 
        position++; 
        value *= factor(); 
    } 
    return value; 
}

function expression() { 
    let value = term(); 
    while (tokens[position] === '+' || tokens[position] === '-') { 
        const op = tokens[position];
        position++;
        const right = term(); 
        value = op === '+' ? value + right : value - right; 
    } 
    return value; 
}

const line = fs.readFileSync(0, 'utf8').split('\n')[0] || '';
const tokens = line.match(/\d+|[()+*-]/g) || [];
let position = 0;

console.log(expression());
