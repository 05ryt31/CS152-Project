import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let lines = [];
rl.on('line', (line) => {
  lines.push(line);
}).on('close', () => {
  const [first, ...edges] = lines;
  const [n, m] = first.split(/\s+/).map(Number);
  const neighbours = Array.from({ length: n + 1 }, () => []);

  edges.forEach((edge) => {
    const [u, v] = edge.split(/\s+/).map(Number);
    neighbours[u].push(v);
    neighbours[v].push(u);
  });

  const [start, target] = lines.pop().split(/\s+/).map(Number);
  const distance = Array(n + 1).fill(-1);
  const queue = [start];
  distance[start] = 0;

  while (queue.length > 0) {
    const node = queue.shift();
    if (node === target) break;
    for (const other of neighbours[node]) {
      if (distance[other] === -1) {
        distance[other] = distance[node] + 1;
        queue.push(other);
      }
    }
  }

  console.log(distance[target]);
});
