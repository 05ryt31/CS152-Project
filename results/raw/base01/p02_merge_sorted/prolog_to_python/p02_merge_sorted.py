import sys

def read_line():
    return sys.stdin.readline().strip()

def nums(line):
    if line == "":
        return []
    parts = line.split()
    return list(map(int, parts))

def merge(xs, ys):
    if not xs:
        return ys
    if not ys:
        return xs
    if xs[0] <= ys[0]:
        return [xs[0]] + merge(xs[1:], ys)
    else:
        return [ys[0]] + merge(xs, ys[1:])

def print_nums(nums):
    print(' '.join(map(str, nums)))

def main():
    a_line = read_line()
    b_line = read_line()
    a = nums(a_line)
    b = nums(b_line)
    result = merge(a, b)
    print_nums(result)

if __name__ == "__main__":
    main()
