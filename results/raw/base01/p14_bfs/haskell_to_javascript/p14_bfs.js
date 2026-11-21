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
    const [n, m] = lines.shift().split(' ').map(Number);
    const edges = lines.slice(0, m).map(edge => edge.split(' ').map(Number));
    const [s, t] = lines[m].split(' ').map(Number);

    const graph = new Map();
    edges.forEach(([u, v]) => {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    });

    function bfs(start, target) {
        const queue = [[start, 0]];
        const seen = new Set([start]);

        while (queue.length > 0) {
            const [node, distance] = queue.shift();
            if (node === target) return distance;
            const neighbors = graph.get(node) || [];
            neighbors.forEach(neighbor => {
                if (!seen.has(neighbor)) {
                    seen.add(neighbor);
                    queue.push([neighbor, distance + 1]);
                }
            });
        }

        return -1;
    }

    const result = bfs(s, t);
    console.log(result);
});
