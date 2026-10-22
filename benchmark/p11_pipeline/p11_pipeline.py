import sys


def apply_stage(values, parts):
    kind = parts[0]
    name = parts[1]
    if kind == "map":
        amount = int(parts[2])
        result = []
        for v in values:
            if name == "add":
                result.append(v + amount)
            else:
                result.append(v * amount)
        return result
    if kind == "filter":
        result = []
        for v in values:
            if name == "even" and v % 2 == 0:
                result.append(v)
            elif name == "odd" and v % 2 != 0:
                result.append(v)
            elif name == "gt" and v > int(parts[2]):
                result.append(v)
        return result
    # reduce
    if name == "sum":
        total = 0
        for v in values:
            total += v
        return total
    if len(values) == 0:
        return "none"
    best = values[0]
    for v in values:
        if v > best:
            best = v
    return best


def main():
    values = []
    for token in sys.stdin.readline().split():
        values.append(int(token))
    k = int(sys.stdin.readline())
    for _ in range(k):
        values = apply_stage(values, sys.stdin.readline().split())
    if isinstance(values, list):
        if len(values) > 0:
            print(" ".join(str(v) for v in values))
    else:
        print(values)


main()
