import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
});

let lines = [];
rl.on('line', (line) => {
  lines.push(line);
}).on('close', () => {
  const [n, m] = lines.shift().split(' ').map(Number);
  const neighbours = {};
  for (let i = 1; i <= n; i++) {
    neighbours[i] = [];
  }
  for (let i = 0; i < m; i++) {
    const [u, v] = lines.shift().split(' ').map(Number);
    neighbours[u].push(v);
    neighbours[v].push(u);
  }
  const [s, t] = lines.shift().split(' ').map(Number);
  const distance = { [s]: 0 };
  const queue = [s];
  let head = 0;
  while (head < queue.length) {
    const node = queue[head];
    head++;
    if (node === t) {
      break;
    }
    for (const other of neighbours[node]) {
      if (!(other in distance)) {
        distance[other] = distance[node] + 1;
        queue.push(other);
      }
    }
  }
  if (t in distance) {
    console.log(distance[t]);
  } else {
    console.log(-1);
  }
});
