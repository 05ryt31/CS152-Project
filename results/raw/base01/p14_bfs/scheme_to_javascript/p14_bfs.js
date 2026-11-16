import { createInterface } from 'node:readline';
import { readFileSync } from 'node:fs';

const rl = createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

function readGraph(m) {
  const graph = [];
  for (let i = 0; i < m; i++) {
    const [u, v] = readline().split(' ').map(Number);
    graph.push([u, v]);
    graph.push([v, u]);
  }
  return graph;
}

function getNeighbors(node, graph) {
  return graph.filter(edge => edge[0] === node || edge[1] === node).map(edge => edge[0] === node ? edge[1] : edge[0]);
}

function expandLayer(layer, graph, visited) {
  const next = new Set();
  for (const node of layer) {
    for (const neighbor of getNeighbors(node, graph)) {
      if (!visited.has(neighbor)) {
        next.add(neighbor);
        visited.add(neighbor);
      }
    }
  }
  return [Array.from(next), [...visited]];
}

function bfs(start, target, graph) {
  let layer = [start];
  let visited = new Set([start]);
  let dist = 0;

  while (layer.length > 0) {
    if (layer.includes(target)) {
      return dist;
    }
    [layer, visited] = expandLayer(layer, graph, visited);
    dist++;
  }

  return -1;
}

const lines = readFileSync(0, 'utf8').split('\n');
const [n, m] = lines[0].split(' ').map(Number);
const graph = readGraph(m);
const [s, t] = lines[2].split(' ').map(Number);

console.log(bfs(s, t, graph));
