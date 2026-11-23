from collections import deque
 
def bfs(graph, start, end):
    queue = deque([start])
    seen = set()
    while len(queue) > 0:
        vertex = queue.popleft()
        if vertex == end:
            return True
        elif vertex not in seen:
            seen.add(vertex)
            queue += graph[vertex] - seen
    return False
 
if __name__ == '__main__':
    graph = {
        "A": {"B", "C"},
        "B": {"A", "D", "E"},
        "C": {"A", "F"},
        "D": {"B"},
        "E": {"B", "F"},
        "F": {"C", "E"}
    }
    print(bfs(graph, "A", "F"))
    print(bfs(graph, "A", "B"))
    print(bfs(graph, "A", "Z"))
