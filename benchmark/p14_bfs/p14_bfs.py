import sys


def main():
    n, m = [int(x) for x in sys.stdin.readline().split()]
    neighbours = {}
    for node in range(1, n + 1):
        neighbours[node] = []
    for _ in range(m):
        u, v = [int(x) for x in sys.stdin.readline().split()]
        neighbours[u].append(v)
        neighbours[v].append(u)
    s, t = [int(x) for x in sys.stdin.readline().split()]
    distance = {s: 0}
    queue = [s]
    head = 0
    while head < len(queue):
        node = queue[head]
        head += 1
        if node == t:
            break
        for other in neighbours[node]:
            if other not in distance:
                distance[other] = distance[node] + 1
                queue.append(other)
    if t in distance:
        print(distance[t])
    else:
        print(-1)


main()
