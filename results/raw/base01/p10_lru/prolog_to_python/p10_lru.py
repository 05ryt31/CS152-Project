import sys

def p10_lru():
    c_line = input().strip()
    n_line = input().strip()
    c = int(c_line)
    n = int(n_line)
    run(n, c, [])

def run(n, c, cache):
    if n == 0:
        return
    line = input().strip()
    parts = line.split(" ")
    operation(parts, c, cache)

def operation(parts, c, cache):
    if parts[0] == "get":
        key = int(parts[1])
        for i, (k, v) in enumerate(cache):
            if k == key:
                print(v)
                new_cache = [(cache[i][0], cache[i][1])] + cache[:i] + cache[i+1:]
                run(n-1, c, new_cache)
                return
        print(-1)
        run(n-1, c, cache)
    elif parts[0] == "put":
        key = int(parts[1])
        value = int(parts[2])
        if c == 0:
            return
        if any(k == key for k, _ in cache):
            new_cache = [(key, value)] + [item for item in cache if item[0] != key]
            run(n-1, c, new_cache)
        else:
            if len(cache) >= c:
                new_cache = [(key, value)] + cache[:-1]
            else:
                new_cache = [(key, value)] + cache
            run(n-1, c, new_cache)

if __name__ == "__main__":
    p10_lru()
