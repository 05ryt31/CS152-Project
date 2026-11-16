import sys

def find_value(key, entries):
    return next((v for k, v in entries if k == key), None)

def remove_key(key, entries):
    return [(k, v) for k, v in entries if k != key]

def remove_from_order(key, order):
    return [x for x in order if x != key]

def touch(key, order):
    return [x for x in order if x != key] + [key]

def lru(capacity, n):
    entries = []
    order = []
    for _ in range(n):
        parts = input().split()
        op = parts[0]
        key = int(parts[1])
        if op == "get":
            value = find_value(key, entries)
            print(value if value is not None else -1)
            if value is not None:
                order = touch(key, order)
        else:
            value = int(parts[2])
            existing = find_value(key, entries)
            new_entries = remove_key(key, entries) + [(key, value)]
            new_order = touch(key, order)
            if not existing and len(new_order) > capacity:
                oldest = new_order[0]
                new_entries = remove_key(oldest, new_entries)
                new_order = new_order[1:]
            entries = new_entries
            order = new_order

capacity = int(input())
n = int(input())
lru(capacity, n)
