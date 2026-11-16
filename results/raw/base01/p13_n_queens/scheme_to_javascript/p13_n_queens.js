import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.question('', (input) => {
  const n = parseInt(input.trim(), 10);
  console.log(nQueensCount(n));
  process.exit(0);
});

function nQueensCount(n) {
  function safe(queens, col) {
    let dist = 1;
    for (let i = 0; i < queens.length; i++) {
      if (queens[i] === col || Math.abs(queens[i] - col) === dist) {
        return false;
      }
      dist++;
    }
    return true;
  }

  function count(row, queens) {
    if (row === n) {
      return 1;
    }
    let total = 0;
    for (let col = 0; col < n; col++) {
      if (safe(queens, col)) {
        total += count(row + 1, [...queens, col]);
      }
    }
    return total;
  }

  return count(0, []);
}
