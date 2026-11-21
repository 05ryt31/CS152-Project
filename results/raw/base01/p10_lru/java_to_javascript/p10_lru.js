import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let capacity;
let n;
let cache = new Map();

rl.on('line', (line) => {
  if (!capacity) {
    capacity = parseInt(line);
  } else if (!n) {
    n = parseInt(line);
  } else {
    const [operation, key, value] = line.split(/\s+/);
    key = parseInt(key);
    value = parseInt(value);

    if (operation === 'get') {
      console.log(cache.has(key) ? cache.get(key) : -1);
    } else {
      cache.set(key, value);
      if (cache.size > capacity) {
        cache.delete(cache.keys().next().value);
      }
    }

    if (--n === 0) {
      rl.close();
    }
  }
});
