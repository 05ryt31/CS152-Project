import sys


def main():
    line = sys.stdin.readline()
    seen = set()
    unique = []
    for token in line.split():
        value = int(token)
        if value not in seen:
            seen.add(value)
            unique.append(value)
    if len(unique) > 0:
        print(" ".join(str(x) for x in unique))


main()
