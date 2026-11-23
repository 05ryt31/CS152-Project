from collections import deque
 
def bfs(graph, start, end):
    queue = deque([start])
    visited = set()
    while queue:
        vertex = queue.popleft()
        if vertex not in visited:
            visited.add(vertex)
            if vertex is end:
                return True
            queue.extend(graph[vertex] - visited)
    return False
 
if __name__ == '__main__':
    graph = {
        'A': {'B', 'C'},
        'B': {'A', 'D', 'E'},
        'C': {'A', 'F'},
        'D': {'B'},
        'E': {'B', 'F'},
        'F': {'C', 'E'}
    }
    print(bfs(graph, 'A', 'F')) # True
    print(bfs(graph, 'A', 'B')) # True
    print(bfs(graph, 'A', 'D')) # True
    print(bfs(graph, 'A', 'E')) # True
    print(bfs(graph, 'A', 'G')) # False
