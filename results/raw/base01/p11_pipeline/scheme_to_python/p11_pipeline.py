import sys

def numbers(line):
    return [] if line == "" else list(map(int, line.split()))

def sum_values(values):
    return 0 if not values else sum(values)

def maximum_value(values):
    return None if not values else max(values)

def keep(predicate, values):
    return [value for value in values if predicate(value)]

def apply_stage(values, parts):
    kind, name = parts[0], parts[1]
    if kind == "map":
        amount = int(parts[2])
        if name == "add":
            return [value + amount for value in values]
        else:
            return [value * amount for value in values]
    elif kind == "filter":
        if name == "even":
            return keep(lambda x: x % 2 == 0, values)
        elif name == "odd":
            return keep(lambda x: x % 2 != 0, values)
        else:
            threshold = int(parts[2])
            return keep(lambda x: x > threshold, values)
    elif name == "sum":
        return sum_values(values)
    elif not values:
        return "none"
    else:
        return maximum_value(values)

def pipeline(k, values):
    for _ in range(k):
        parts = input().split()
        values = apply_stage(values, parts)
    if isinstance(values, list):
        if values:
            print(values[0], end='')
            for value in values[1:]:
                print(f" {value}", end='')
            print()
        else:
            print("none")
    else:
        print(values)

values = numbers(input())
k = int(input())
pipeline(k, values)
