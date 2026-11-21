import sys

lines = sys.stdin.read().split('\n')
n, m = map(int, lines[0].split())
graph = [[] for _ in range(n + 1)]

for i in range(m):
    u, v = map(int, lines[i + 1].split())
    graph[u].append(v)
    graph[v].append(u)

start, target = map(int, lines[m + 1].split())
distance = [-1] * (n + 1)
queue = [start]
distance[start] = 0

while queue:
    node = queue.pop(0)
    if node == target:
        break
    for next_node in graph[node]:
        if distance[next_node] < 0:
            distance[next_node] = distance[node] + 1
            queue.append(next_node)

print(distance[target])
