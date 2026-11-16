import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

function numbers(line) {
  if (line === "") return [];
  return line.split(' ').map(Number);
}

function sum(values) {
  return values.reduce((acc, val) => acc + val, 0);
}

function maximum(values) {
  return Math.max(...values);
}

function keep(predicate, values) {
  return values.filter(predicate);
}

function applyStage(values, parts) {
  const [kind, name] = parts;
  if (kind === "map") {
    const amount = Number(parts[2]);
    if (name === "add") {
      return values.map(x => x + amount);
    } else {
      return values.map(x => x * amount);
    }
  } else if (kind === "filter") {
    if (name === "even") {
      return keep(x => x % 2 === 0, values);
    } else if (name === "odd") {
      return keep(x => x % 2 !== 0, values);
    } else {
      const threshold = Number(parts[2]);
      return keep(x => x > threshold, values);
    }
  } else if (name === "sum") {
    return sum(values);
  } else if (values.length === 0) {
    return 'none';
  } else {
    return maximum(values);
  }
}

async function pipeline(k, values) {
  let result = values;
  for (let i = 0; i < k; i++) {
    const parts = await new Promise(resolve => rl.question('', resolve)).split(' ');
    result = applyStage(result, parts);
  }
  if (Array.isArray(result)) {
    if (result.length > 0) {
      process.stdout.write(`${result[0]}`);
      for (let j = 1; j < result.length; j++) {
        process.stdout.write(` ${result[j]}`);
      }
      process.stdout.write('\n');
    } else {
      console.log('none');
    }
  } else {
    console.log(result);
  }
}

(async () => {
  const values = numbers(await new Promise(resolve => rl.question('', resolve)));
  const k = Number(await new Promise(resolve => rl.question('', resolve)));
  await pipeline(k, values);
})();
