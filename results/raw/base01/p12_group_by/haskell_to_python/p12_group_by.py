import sys

def process_rows(rows):
    grouped = {}
    for row in rows:
        parts = row.split()
        if len(parts) == 2:
            key, value = parts
            v = int(value)
            if key in grouped:
                grouped[key] = (grouped[key][0] + v, grouped[key][1] + 1)
            else:
                grouped[key] = (v, 1)
    return [f"{key} {s} {c}" for key, (s, c) in sorted(grouped.items())]

def main():
    n = int(input())
    rows = [input() for _ in range(n)]
    processed_rows = process_rows(rows)
    for row in processed_rows:
        print(row)

if __name__ == "__main__":
    main()
