import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let input = '';

rl.on('line', (line) => {
  input += line + '\n';
});

rl.on('close', () => {
  const lines = input.trim().split('\n');
  const N = parseInt(lines[0].trim(), 10);
  const result = countNQueens(N);
  console.log(result);
  process.exit(0);
});

function countNQueens(n) {
  let count = 0;
  backtrack(n, 0, [], count);
  return count;
}

function backtrack(n, row, columns, count) {
  if (row === n) {
    count++;
    return;
  }
  for (let col = 0; col < n; col++) {
    if (isSafe(columns, row, col)) {
      backtrack(n, row + 1, [col, ...columns], count);
    }
  }
}

function isSafe(columns, row, col) {
  for (let i = 0; i < row; i++) {
    if (columns[i] === col || Math.abs(columns[i] - col) === row - i) {
      return false;
    }
  }
  return true;
}
