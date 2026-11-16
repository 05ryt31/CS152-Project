import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let values = [];
rl.on('line', (line) => {
  if (!values.length) {
    values = line.split(' ').map(Number);
  } else if (k === undefined) {
    k = parseInt(line);
  } else {
    const [kind, name, ...rest] = line.split(' ');
    values = applyStage(values, kind, name, rest);
  }
}).on('close', () => {
  if (Array.isArray(values)) {
    if (values.length > 0) {
      console.log(values.join(' '));
    }
  } else {
    console.log(values);
  }
  process.exit(0);
});

function applyStage(values, kind, name, rest) {
  if (kind === 'map') {
    const amount = parseInt(rest[0]);
    if (name === 'add') {
      return values.map(v => v + amount);
    } else {
      return values.map(v => v * amount);
    }
  }
  if (kind === 'filter') {
    if (name === 'even') {
      return values.filter(v => v % 2 === 0);
    } else if (name === 'odd') {
      return values.filter(v => v % 2 !== 0);
    } else if (name === 'gt') {
      const threshold = parseInt(rest[0]);
      return values.filter(v => v > threshold);
    }
  }
  // reduce
  if (name === 'sum') {
    return values.reduce((total, v) => total + v, 0);
  }
  if (values.length === 0) {
    return 'none';
  }
  let best = values[0];
  for (const v of values) {
    if (v > best) {
      best = v;
    }
  }
  return best;
}
