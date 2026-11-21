import sys

def read_int():
    return int(input().strip())

def read_line():
    return input().strip()

def split_string(s, sep):
    return s.split(sep)

def number_string(n):
    return str(n)

def edges(m, graph, result):
    if m == 0:
        result[0] = graph
    else:
        line = read_line()
        us, vs = split_string(line, " ")
        u, v = int(us), int(vs)
        new_graph = add_edge(u, v, graph)
        n1 = m - 1
        edges(n1, new_graph, result)

def add_edge(u, v, graph):
    new_graph = update_adj(u, v, graph)
    new_graph = update_adj(v, u, new_graph)
    return new_graph

def update_adj(u, v, graph):
    if not graph:
        return {u: [v]}
    elif list(graph.keys())[0] == u:
        neighbors = graph[u]
        if v in neighbors:
            return graph
        else:
            return {u: neighbors + [v]}
    else:
        other_key = list(graph.keys())[1]
        rest = graph[other_key]
        new_rest = update_adj(u, v, rest)
        return {other_key: new_rest}

def adj(node, graph):
    if node in graph:
        return graph[node][0]

def bfs(queue, seen, graph, target, result):
    if not queue:
        result[0] = -1
    elif queue[0][0] == target:
        result[0] = queue[0][1]
    else:
        node, distance = queue[0]
        neighbors = adj(node, graph)
        new_seen, added = unseen(neighbors, seen)
        distance1 = distance + 1
        entries = pairs(added, distance1)
        new_queue = queue[1:] + entries
        bfs(new_queue, new_seen, graph, target, result)

def unseen(neighbors, seen):
    new_seen = seen.copy()
    added = []
    for x in neighbors:
        if x in seen:
            continue
        new_seen.add(x)
        added.append(x)
    return new_seen, added

def pairs(nodes, distance):
    return [(node, distance) for node in nodes]

def main():
    first_line = read_line()
    ns, ms = split_string(first_line, " ")
    n, m = int(ns), int(ms)
    graph = {}
    edges(m, graph, [graph])
    last_line = read_line()
    ss, ts = split_string(last_line, " ")
    s, t = int(ss), int(ts)
    result = [-1]
    bfs([(s, 0)], set(), graph, t, result)
    print(result[0])

if __name__ == "__main__":
    main()
