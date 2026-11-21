import { createInterface } from 'node:readline';
import { stdin, stdout } from 'node:process';

const rl = createInterface({
  input: stdin,
  output: stdout,
  terminal: false
});

let lines = [];
rl.on('line', (line) => {
  lines.push(line);
});

rl.on('close', () => {
  const n = parseInt(lines.shift(), 10);
  let groups = readGroups(n, lines);
  printGroups(groups);
  process.exit(0);
});

function readGroups(n, lines) {
  let i = 0;
  let groups = [];
  while (i < n) {
    const [key, value] = lines[i].split(' ');
    groups = update(key, parseInt(value, 10), groups);
    i++;
  }
  return groups;
}

function printGroups(groups) {
  groups.sort((a, b) => a[0].localeCompare(b[0]));
  groups.forEach(([key, count, total]) => {
    console.log(`${key} ${count} ${total}`);
  });
}

function update(key, value, groups) {
  const entry = groups.find(group => group[0] === key);
  if (entry) {
    entry[1] += value;
    entry[2]++;
  } else {
    groups.push([key, value, 1]);
  }
  return groups.filter(group => group[0] !== key);
}
