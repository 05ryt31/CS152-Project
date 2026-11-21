import sys

def touch(key, order):
    return [x for x in order if x != key] + [key]

def run_lru(cap, commands):
    values = {}
    order = []
    outputs = []

    for command in commands:
        parts = command.split()
        if parts[0] == "get":
            key = int(parts[1])
            if key in values:
                outputs.append(str(values[key]))
                order = touch(key, order)
            else:
                outputs.append("-1")

        elif parts[0] == "put":
            key = int(parts[1])
            value = int(parts[2])
            values[key] = value
            order = touch(key, order)
            if len(order) > cap:
                oldest = order.pop(0)
                del values[oldest]

    return outputs

if __name__ == "__main__":
    cap = int(input())
    n = int(input())
    commands = [input().strip() for _ in range(n)]
    print("\n".join(run_lru(cap, commands)))
