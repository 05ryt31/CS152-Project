import fs from 'node:fs';

const lines = fs.readFileSync(0, 'utf8').split('\n')
const [n, m] = lines[0].split(/\s+/).map(Number);
const graph = Array.from({ length: n + 1 }, () => []);

for (let i = 0; i < m; i++) { 
    const [u, v] = lines[i + 1].split(/\s+/).map(Number); 
    graph[u].push(v); 
    graph[v].push(u); 
}

const [start, target] = lines[m + 1].split(/\s+/).map(Number);
const distance = Array(n + 1).fill(-1);
const queue = [start]; 
distance[start] = 0;

for (let head = 0; head < queue.length; head++) { 
    const node = queue[head];
    if (node === target) break;
    for (const next of graph[node]) {
        if (distance[next] < 0) { 
            distance[next] = distance[node] + 1; 
            queue.push(next); 
        } 
    }
}

console.log(distance[target]);
