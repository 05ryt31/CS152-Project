import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let lines = [];
rl.on('line', (line) => {
  lines.push(line);
}).on('close', () => {
  const ALine = lines[0];
  const BLine = lines[1];
  const A = nums(ALine);
  const B = nums(BLine);
  const Result = merge(A, B);
  printNums(Result);
  process.exit(0);
});

function nums(line) {
  if (line === '') return [];
  const parts = line.split(' ');
  if (parts.length === 0) return [];
  return parts.map(Number);
}

function merge(Xs, Ys) {
  if (Xs.length === 0) return Ys;
  if (Ys.length === 0) return Xs;
  if (Xs[0] <= Ys[0]) {
    return [Xs[0], ...merge(Xs.slice(1), Ys)];
  } else {
    return [Ys[0], ...merge(Xs, Ys.slice(1))];
  }
}

function printNums(nums) {
  console.log(nums.join(' '));
}
