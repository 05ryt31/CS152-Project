from collections import deque
 
def bfs(graph, start, goal):
    queue = deque()
    queue.append((start, [start]))
    while queue:
        (vertex, path) = queue.popleft()
        for next in set(graph[vertex]) - set(path):
            if next == goal:
                yield path + [next]
            else:
                queue.append((next, path + [next]))
 
graph = {'A': ['B', 'C'],
         'B': ['D', 'E'],
         'C': ['F'],
         'D': [],
         'E': ['F'],
         'F': []}
print(list(bfs(graph, 'A', 'F')))
