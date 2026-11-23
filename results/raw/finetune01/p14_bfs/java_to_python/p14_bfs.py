from collections import deque
 
def bfs(graph, start, end):
    path = []
    visited = set()
    queue = deque([start])
    while queue:
        vertex = queue.popleft()
        if vertex not in visited:
            visited.add(vertex)
            path.append(vertex)
            if vertex == end:
                return path
            queue.extend(graph[vertex] - visited)
    return None
 
if __name__ == '__main__':
    graph = {'A': set(['B', 'C']),
             'B': set(['A', 'D', 'E']),
             'C': set(['A', 'F']),
             'D': set(['B']),
             'E': set(['B', 'F']),
             'F': set(['C', 'E'])}
    print(bfs(graph, 'A', 'F')) # {'A', 'C', 'F'}
    print(bfs(graph, 'A', 'D')) # {'A', 'B', 'D'}
