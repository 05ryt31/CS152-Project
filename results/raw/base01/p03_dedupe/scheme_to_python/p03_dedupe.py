import sys

def numbers(line):
    if line == "":
        return []
    return list(map(int, line.split()))

def dedupe(values, seen=None):
    if seen is None:
        seen = set()
    if not values:
        return []
    value = values[0]
    if value in seen:
        return dedupe(values[1:], seen)
    seen.add(value)
    return [value] + dedupe(values[1:], seen)

def print_list(values):
    if values:
        print(' '.join(map(str, values)))

def safe_read_line():
    try:
        return input().strip()
    except EOFError:
        return ""

print_list(dedupe(numbers(safe_read_line())))
