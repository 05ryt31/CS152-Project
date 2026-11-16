import sys

def numbers(line):
    return [] if line == "" else list(map(int, line.split()))

def merge(a, b):
    if not a:
        return b
    if not b:
        return a
    if a[0] <= b[0]:
        return [a[0]] + merge(a[1:], b)
    else:
        return [b[0]] + merge(a, b[1:])

def print_list(values):
    if values:
        print(' '.join(map(str, values)))

def safe_read_line():
    try:
        return input()
    except EOFError:
        return ""

print_list(merge(numbers(safe_read_line()), numbers(safe_read_line())))
