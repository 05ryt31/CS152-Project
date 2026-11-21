import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let values = [];
rl.on('line', (line) => {
  if (values.length === 0) {
    values = line.split(/\s+/).filter(Boolean).map(Number);
  } else if (k === undefined) {
    k = parseInt(line);
  } else {
    const [command, type, ...args] = line.split(/\s+/);
    if (command === 'map') {
      const amount = parseInt(args[1]);
      values = values.map(value => type === 'add' ? value + amount : value * amount);
    } else if (command === 'filter') {
      values = values.filter(value => {
        if (type === 'even') return value % 2 === 0;
        if (type === 'odd') return value % 2 !== 0;
        if (type === 'gt') return value > parseInt(args[1]);
        return false;
      });
    } else if (type === 'sum') {
      const sum = values.reduce((acc, val) => acc + val, 0);
      console.log(sum);
      process.exit(0);
    } else {
      if (values.length === 0) {
        console.log('none');
      } else {
        const max = Math.max(...values);
        console.log(max);
      }
      process.exit(0);
    }
  }
}).on('close', () => {
  if (Array.isArray(values)) {
    if (values.length > 0) {
      console.log(values.join(' '));
    }
  } else {
    console.log(values);
  }
});
