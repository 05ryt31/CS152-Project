import sys

def bfs(n, m, edges, start, target):
    neighbors = [[] for _ in range(n + 1)]
    for u, v in edges:
        neighbors[u].append(v)
        neighbors[v].append(u)

    distance = [-1] * (n + 1)
    queue = [start]
    distance[start] = 0

    while queue:
        node = queue.pop(0)
        if node == target:
            break
        for other in neighbors[node]:
            if distance[other] == -1:
                distance[other] = distance[node] + 1
                queue.append(other)

    return distance[target]

if __name__ == "__main__":
    input = sys.stdin.read
    data = input().split()
    
    index = 0
    n = int(data[index])
    index += 1
    m = int(data[index])
    index += 1
    
    edges = []
    for _ in range(m):
        u = int(data[index])
        index += 1
        v = int(data[index])
        index += 1
        edges.append((u, v))
    
    start = int(data[index])
    index += 1
    target = int(data[index])
    index += 1
    
    result = bfs(n, m, edges, start, target)
    print(result)
