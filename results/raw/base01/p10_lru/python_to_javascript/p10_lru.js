import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let capacity;
let n;
let values = {};
let order = [];

rl.on('line', (input) => {
  if (!capacity) {
    capacity = parseInt(input);
  } else if (!n) {
    n = parseInt(input);
  } else {
    const [command, key, value] = input.split();
    const parsedKey = parseInt(key);
    if (command === 'get') {
      if (values.hasOwnProperty(parsedKey)) {
        const index = order.indexOf(parsedKey);
        order.splice(index, 1);
        order.push(parsedKey);
        console.log(values[parsedKey]);
      } else {
        console.log(-1);
      }
    } else {
      if (values.hasOwnProperty(parsedKey)) {
        const index = order.indexOf(parsedKey);
        order.splice(index, 1);
      } else if (order.length === capacity) {
        const oldest = order.shift();
        delete values[oldest];
      }
      values[parsedKey] = parseInt(value);
      order.push(parsedKey);
    }
  }
}).on('close', () => {
  process.exit(0);
});
