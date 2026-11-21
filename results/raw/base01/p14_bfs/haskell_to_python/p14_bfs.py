from collections import defaultdict, deque
import sys

def read_nums(s):
    return list(map(int, s.split()))

def main():
    input_line = input().strip()
    n, m = read_nums(input_line)
    
    edges = []
    for _ in range(m):
        input_line = input().strip()
        edges.append(read_nums(input_line))
    
    input_line = input().strip()
    s, t = read_nums(input_line)
    
    graph = defaultdict(list)
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)
    
    def bfs(start, target):
        queue = deque([(start, 0)])
        seen = set([start])
        
        while queue:
            node, distance = queue.popleft()
            if node == target:
                return distance
            for neighbor in graph[node]:
                if neighbor not in seen:
                    seen.add(neighbor)
                    queue.append((neighbor, distance + 1))
        
        return -1
    
    result = bfs(s, t)
    print(result)

if __name__ == "__main__":
    main()
