import sys

def keep(predicate, values):
    return [value for value in values if predicate(value)]

def without(key, groups):
    return [group for group in groups if group[0] != key]

def update(key, value, groups):
    for i, group in enumerate(groups):
        if group[0] == key:
            groups[i] = [key, group[1] + value, group[2] + 1]
            return groups
    groups.append([key, value, 1])
    return groups

def read_groups(n):
    groups = []
    for _ in range(n):
        parts = input().split()
        groups = update(parts[0], int(parts[1]), groups)
    return groups

def print_groups(groups):
    sorted_groups = sorted(groups, key=lambda x: x[0])
    for group in sorted_groups:
        print(group[0], group[1], group[2])

n = int(input())
groups = read_groups(n)
print_groups(groups)
