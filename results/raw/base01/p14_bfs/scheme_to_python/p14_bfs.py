import sys

def read_graph(m):
    graph = []
    for _ in range(m):
        uv = list(map(int, input().split()))
        u, v = uv[0], uv[1]
        graph.append((u, v))
        graph.append((v, u))
    return graph

def get_neighbors(node, graph):
    neighbors = [v for u, v in graph if u == node]
    return neighbors

def expand_layer(layer, graph, visited):
    next_layer = []
    new_visited = visited.copy()
    for u in layer:
        for v in get_neighbors(u, graph):
            if v not in new_visited:
                next_layer.append(v)
                new_visited.add(v)
    return next_layer, new_visited

def bfs(start, target, graph):
    layer = [start]
    visited = {start}
    distance = 0
    while layer:
        if target in layer:
            return distance
        layer, visited = expand_layer(layer, graph, visited)
        distance += 1
    return -1

nm = list(map(int, input().split()))
n, m = nm[0], nm[1]
graph = read_graph(m)
st = list(map(int, input().split()))
s, t = st[0], st[1]

print(bfs(s, t, graph))
