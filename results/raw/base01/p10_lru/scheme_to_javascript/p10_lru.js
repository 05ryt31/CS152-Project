import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let capacity;
let n;

rl.on('line', (line) => {
  if (!capacity && !n) {
    [capacity, n] = line.split(' ').map(Number);
  } else {
    const [op, keyStr, valStr] = line.split(' ');
    const key = Number(keyStr);
    let value = Number(valStr);

    if (op === 'get') {
      console.log(getValue(key));
    } else {
      setValue(key, value);
    }
  }
}).on('close', () => {
  process.exit(0);
});

const entries = {};
const order = [];

function getValue(key) {
  const entry = entries[key];
  if (entry) {
    touch(key);
    return entry.value;
  }
  return -1;
}

function setValue(key, value) {
  const existing = entries[key];
  if (existing) {
    existing.value = value;
    touch(key);
  } else {
    entries[key] = { value };
    order.push(key);
    if (order.length > capacity) {
      const oldest = order.shift();
      delete entries[oldest];
    }
  }
}

function touch(key) {
  const index = order.indexOf(key);
  if (index !== -1) {
    order.splice(index, 1);
    order.push(key);
  }
}
