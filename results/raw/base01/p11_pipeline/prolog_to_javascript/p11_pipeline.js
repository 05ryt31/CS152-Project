import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

async function main() {
  const line1 = await new Promise(resolve => rl.question('', resolve));
  const parts = line1.split(' ');
  const values = parts.map(Number);

  const kLine = await new Promise(resolve => rl.question('', resolve));
  const k = Number(kLine);

  let result = values;
  for (let i = 0; i < k; i++) {
    const line = await new Promise(resolve => rl.question('', resolve));
    const stageParts = line.split(' ');
    result = applyStage(stageParts, result);
  }

  output(result);
  rl.close();
}

function applyStage(parts, values) {
  switch (parts[0]) {
    case 'map':
      if (parts[1] === 'add') return values.map(x => x + Number(parts[2]));
      if (parts[1] === 'mul') return values.map(x => x * Number(parts[2]));
      break;
    case 'filter':
      if (parts[1] === 'even') return values.filter(x => x % 2 === 0);
      if (parts[1] === 'odd') return values.filter(x => x % 2 !== 0);
      if (parts[1] === 'gt') return values.filter(x => x > Number(parts[2]));
      break;
    case 'reduce':
      if (parts[1] === 'sum') return [values.reduce((a, b) => a + b, 0)];
      if (parts[1] === 'max') return [Math.max(...values)];
      break;
  }
  return values;
}

function output(values) {
  if (values.length === 0 || values[0] === undefined) {
    console.log('none');
  } else {
    console.log(values.join(' '));
  }
}

main();
