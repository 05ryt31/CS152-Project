from collections import deque
 
def bfs(graph, start, end):
    queue = deque([start])
    visited = set()
    while queue:
        vertex = queue.popleft()
        if vertex == end:
            return True
        elif vertex not in visited:
            visited.add(vertex)
            queue += graph[vertex]
    return False
 
graph = {'A': ['B', 'C'],
         'B': ['D', 'E'],
         'C': ['F'],
         'D': [],
         'E': ['F'],
         'F': []}
print(bfs(graph, 'A', 'F')) # prints: True
print(bfs(graph, 'A', 'D')) # prints: False
