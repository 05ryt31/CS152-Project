import sys

def main():
    line = input().strip()
    parts = line.split()
    values = list(map(int, parts))
    
    k_line = input().strip()
    k = int(k_line)
    
    result = stages(k, values)
    output(result)

def stages(k, values):
    if k == 0:
        return values
    
    line = input().strip()
    parts = line.split()
    new_values = apply_stage(parts, values)
    
    return stages(k - 1, new_values)

def apply_stage(parts, values):
    command, *args = parts
    if command == "map":
        if args[0] == "add":
            n = int(args[1])
            return [x + n for x in values]
        elif args[0] == "mul":
            n = int(args[1])
            return [x * n for x in values]
    elif command == "filter":
        if args[0] == "even":
            return [x for x in values if x % 2 == 0]
        elif args[0] == "odd":
            return [x for x in values if x % 2 != 0]
        elif args[0] == "gt":
            n = int(args[1])
            return [x for x in values if x > n]
    elif command == "reduce":
        if args[0] == "sum":
            return [sum(values)]
        elif args[0] == "max":
            if not values:
                return None
            return [max(values)]

def output(result):
    if result is None:
        print("none")
    elif isinstance(result, list) and len(result) == 0:
        pass
    else:
        print(' '.join(map(str, result)))

if __name__ == "__main__":
    main()
