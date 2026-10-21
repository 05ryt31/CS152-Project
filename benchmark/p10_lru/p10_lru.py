import sys


def main():
    capacity = int(sys.stdin.readline())
    n = int(sys.stdin.readline())
    values = {}
    order = []  # least recently used first
    for _ in range(n):
        parts = sys.stdin.readline().split()
        key = int(parts[1])
        if parts[0] == "get":
            if key in values:
                order.remove(key)
                order.append(key)
                print(values[key])
            else:
                print(-1)
        else:
            if key in values:
                order.remove(key)
            elif len(order) == capacity:
                oldest = order.pop(0)
                del values[oldest]
            values[key] = int(parts[2])
            order.append(key)


main()
