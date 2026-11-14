import fs from 'node:fs';

function safe(columns, row, col) {
    for (let previous = 0; previous < row; previous++) {
        if (columns[previous] === col || Math.abs(columns[previous] - col) === row - previous) {
            return false;
        }
    } 
    return true;
}

function count(row, columns) { 
    if (row === n) return 1; 
    
    let total = 0; 
    for (let col = 0; col < n; col++) { 
        if (safe(columns, row, col)) { 
            columns[row] = col; 
            total += count(row + 1, columns); 
        } 
    }

    return total; 
}

const n = Number(fs.readFileSync(0, 'utf8').trim());
console.log(count(0, Array(n)));
