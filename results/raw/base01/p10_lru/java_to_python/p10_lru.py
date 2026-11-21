from sys import stdin, stdout

def main():
    reader = stdin
    writer = stdout

    capacity = int(next(reader))
    n = int(next(reader))
    cache = OrderedDict()

    for _ in range(n):
        command, key, value = next(reader).strip().split()
        key = int(key)
        if command == "get":
            writer.write(f"{cache.get(key, -1)}\n")
        else:
            cache[key] = int(value)
            if len(cache) > capacity:
                cache.popitem(last=False)

if __name__ == "__main__":
    main()
