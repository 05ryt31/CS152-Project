import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let lines = [];
rl.on('line', (line) => {
  lines.push(line);
});

rl.on('close', () => {
  const line = lines.join('\n');
  const nums = parseNumbers(line);
  const uniqueNums = unique(nums);
  printNumbers(uniqueNums);
  process.exit(0);
});

function parseNumbers(line) {
  if (line === '') return [];
  const parts = line.split(' ');
  return parts.map(Number);
}

function unique(arr) {
  const seen = new Set();
  const result = [];
  for (const num of arr) {
    if (!seen.has(num)) {
      result.push(num);
      seen.add(num);
    }
  }
  return result;
}

function printNumbers(nums) {
  console.log(nums.join(' '));
}
