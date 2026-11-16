import sys

def main():
    lines = sys.stdin.read().split('\n')
    first = (lines[0] or '').strip()

    values = list(map(int, first.split())) if first else []
    k = int(lines[1])
    result = values

    for i in range(k):
        p = lines[i + 2].split()
        if p[0] == 'map':
            op = p[1]
            num = int(p[2])
            if op == 'add':
                result = [x + num for x in result]
            elif op == 'mul':
                result = [x * num for x in result]
        elif p[0] == 'filter':
            op = p[1]
            if op == 'even':
                result = [x for x in result if x % 2 == 0]
            elif op == 'odd':
                result = [x for x in result if x % 2 != 0]
            else:
                threshold = int(p[2])
                result = [x for x in result if x > threshold]
        else:
            op = p[1]
            if op == 'sum':
                result = sum(result)
            elif result:
                result = max(result)
            else:
                result = 'none'

    print(' '.join(map(str, result)) if isinstance(result, list) and result else result)

if __name__ == "__main__":
    main()
