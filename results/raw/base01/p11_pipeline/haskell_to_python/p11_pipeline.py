import sys

def apply(xs, stage):
    parts = stage.split()
    if parts[0] == "map":
        if parts[1] == "add":
            n = int(parts[2])
            return [x + n for x in xs]
        elif parts[1] == "mul":
            n = int(parts[2])
            return [x * n for x in xs]
    elif parts[0] == "filter":
        if parts[1] == "even":
            return [x for x in xs if x % 2 == 0]
        elif parts[1] == "odd":
            return [x for x in xs if x % 2 != 0]
        elif parts[1] == "gt":
            n = int(parts[2])
            return [x for x in xs if x > n]
    elif parts[0] == "reduce":
        if parts[1] == "sum":
            return [sum(xs)]
        elif parts[1] == "max":
            if len(xs) == 0:
                return []
            return [max(xs)]

def read_nums(s):
    return list(map(int, s.split()))

def main():
    values = input().strip()
    k = int(input().strip())
    stages = [input().strip() for _ in range(k)]
    result = values.split()
    for stage in stages:
        result = apply(result, stage)
    result = list(map(int, result))
    if not result and k > 0 and "reduce" in stages[-1]:
        print("none")
    elif result:
        print(' '.join(map(str, result)))

if __name__ == "__main__":
    main()
