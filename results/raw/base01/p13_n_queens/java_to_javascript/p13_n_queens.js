import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
});

rl.question('', (input) => {
  const n = parseInt(input.trim(), 10);
  console.log(count(n, 0, new Array(n).fill(0)));
  rl.close();
});

function safe(columns, row, col) {
  for (let previous = 0; previous < row; previous++) {
    if (columns[previous] === col || Math.abs(columns[previous] - col) === row - previous) return false;
  }
  return true;
}

function count(n, row, columns) {
  if (row === n) return 1;

  let total = 0;
  for (let col = 0; col < n; col++) {
    if (safe(columns, row, col)) {
      columns[row] = col;
      total += count(n, row + 1, columns);
    }
  }

  return total;
}
