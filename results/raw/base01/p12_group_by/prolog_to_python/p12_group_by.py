import sys

def p12_group_by():
    n_line = input().strip()
    n = int(n_line)
    groups = []
    rows(n, [], groups)
    sorted_groups = sorted(groups)
    print_groups(sorted_groups)

def rows(n, groups, result):
    if n == 0:
        result.extend(groups)
    else:
        line = input().strip()
        key, value = line.split(" ", 1)
        v = int(value)
        new_groups = update(key, v, groups)
        n1 = n - 1
        rows(n1, new_groups, result)

def update(key, value, groups):
    for i, (k, s, c) in enumerate(groups):
        if k == key:
            return groups[:i] + [(key, s + value, c + 1)] + groups[i+1:]
    return groups + [(key, value, 1)]

def print_groups(groups):
    for key, s, c in groups:
        print(f"{key} {s} {c}")

if __name__ == "__main__":
    p12_group_by()
