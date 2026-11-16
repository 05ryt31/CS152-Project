import sys

def main():
    reader = sys.stdin
    n = int(next(reader))

    groups = {}
    for _ in range(n):
        parts = next(reader).strip().split()
        key, value = parts[0], int(parts[1])
        if key not in groups:
            groups[key] = [0, 0]
        groups[key][0] += value
        groups[key][1] += 1

    for key, (total, count) in sorted(groups.items()):
        print(f"{key} {total} {count}")

if __name__ == "__main__":
    main()
