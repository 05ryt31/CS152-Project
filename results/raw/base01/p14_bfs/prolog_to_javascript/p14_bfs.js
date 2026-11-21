import { createInterface } from 'node:readline';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

let lines = [];
rl.on('line', (line) => {
  lines.push(line);
});

rl.on('close', () => {
  const [firstLine, lastLine] = lines;
  const [N, M] = firstLine.split(' ').map(Number);
  let graph = [];
  for (let i = 0; i < M; i++) {
    const [U, V] = lines[i + 1].split(' ').map(Number);
    graph = addEdge(U, V, graph);
  }
  const [S, T] = lastLine.split(' ').map(Number);
  const result = bfs([[S, 0]], [S], graph, T);
  console.log(result);
  process.exit(0);
});

function addEdge(u, v, graph) {
  return updateAdj(u, v, graph, []).concat(updateAdj(v, u, graph, []));
}

function updateAdj(node, neighbor, graph, acc) {
  if (graph.length === 0) {
    return [{ [node]: [neighbor] }];
  }
  const [head, ...tail] = graph;
  if (Object.keys(head)[0] == node) {
    return [...acc, { ...head, [node]: head[node].concat(neighbor) }];
  }
  return [head, ...updateAdj(node, neighbor, tail, acc)];
}

function bfs(queue, seen, graph, target) {
  if (queue.length === 0) return -1;
  const [current, distance] = queue.shift();
  if (current === target) return distance;
  const neighbors = getNeighbors(current, graph);
  const unseenNeighbors = neighbors.filter(n => !seen.includes(n));
  const newQueue = queue.concat(unseenNeighbors.map(n => [n, distance + 1]));
  return bfs(newQueue, [...seen, current], graph, target);
}

function getNeighbors(node, graph) {
  return Object.values(graph.find(g => g.hasOwnProperty(node)) || {}).flat();
}
