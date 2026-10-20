import sys


def parse_line(line):
    values = []
    for token in line.split():
        values.append(int(token))
    return values


def main():
    lines = sys.stdin.read().split("\n")
    a = parse_line(lines[0]) if len(lines) > 0 else []
    b = parse_line(lines[1]) if len(lines) > 1 else []
    merged = []
    i = 0
    j = 0
    while i < len(a) and j < len(b):
        if a[i] <= b[j]:
            merged.append(a[i])
            i += 1
        else:
            merged.append(b[j])
            j += 1
    while i < len(a):
        merged.append(a[i])
        i += 1
    while j < len(b):
        merged.append(b[j])
        j += 1
    if len(merged) > 0:
        print(" ".join(str(x) for x in merged))


main()
