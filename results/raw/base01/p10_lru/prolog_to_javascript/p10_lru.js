import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let cacheSize;
let commands;

rl.on('line', (line) => {
  if (!cacheSize) {
    cacheSize = parseInt(line.trim());
  } else if (!commands) {
    commands = line.split(' ').map(Number);
  }
});

rl.on('close', () => {
  const cache = [];
  let index = 0;

  while (index < commands.length) {
    const command = commands[index];
    const key = commands[++index];
    const value = commands[++index];

    if (command === 0) {
      get(cache, key);
    } else if (command === 1) {
      put(cache, cacheSize, key, value);
    }

    index++;
  }
});

function get(cache, key) {
  const entry = cache.find(entry => entry.key === key);
  if (entry) {
    console.log(entry.value);
    entry.order = Date.now();
  } else {
    console.log(-1);
  }
}

function put(cache, capacity, key, value) {
  const existingEntry = cache.find(entry => entry.key === key);
  if (existingEntry) {
    existingEntry.value = value;
    existingEntry.order = Date.now();
  } else {
    if (cache.length >= capacity) {
      cache.sort((a, b) => a.order - b.order);
      cache.shift();
    }
    cache.push({ key, value, order: Date.now() });
  }
}
