import sys

def main():
    reader = sys.stdin.read
    lines = reader().strip().split('\n')
    
    values = list(map(int, lines[0].split()))
    k = int(lines[1])
    
    for i in range(k):
        parts = lines[i + 2].split()
        if parts[0] == "map":
            amount = int(parts[2])
            operation = parts[1]
            if operation == "add":
                values = [x + amount for x in values]
            elif operation == "mul":
                values = [x * amount for x in values]
        elif parts[0] == "filter":
            filter_type = parts[1]
            threshold = int(parts[2]) if filter_type == "gt" else None
            if filter_type == "even":
                values = [x for x in values if x % 2 == 0]
            elif filter_type == "odd":
                values = [x for x in values if x % 2 != 0]
            elif filter_type == "gt":
                values = [x for x in values if x > threshold]
        elif parts[1] == "sum":
            result = sum(values)
        else:
            if not values:
                result = "none"
            else:
                result = max(values)
    
    if isinstance(result, list):
        print(' '.join(map(str, values)))
    else:
        print(result)

if __name__ == "__main__":
    main()
