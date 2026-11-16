def parse(line):
    if line is None or line.strip() == "":
        return []

    parts = line.split()
    values = [int(part) for part in parts]

    return values

def main():
    import sys
    reader = sys.stdin
    a = parse(next(reader))
    b = parse(next(reader))
    result = []
    i = 0
    j = 0

    while i < len(a) and j < len(b):
        if result:
            result.append(' ')
        if a[i] <= b[j]:
            result.append(str(a[i]))
            i += 1
        else:
            result.append(str(b[j]))
            j += 1

    while i < len(a):
        if result:
            result.append(' ')
        result.append(str(a[i]))
        i += 1

    while j < len(b):
        if result:
            result.append(' ')
        result.append(str(b[j]))
        j += 1

    if result:
        print(''.join(result))

if __name__ == "__main__":
    main()
