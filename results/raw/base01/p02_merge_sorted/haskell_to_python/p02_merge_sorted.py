def read_nums(s):
    return list(map(int, s.split()))

def merge(xs, ys):
    if not xs:
        return ys
    if not ys:
        return xs
    if xs[0] <= ys[0]:
        return [xs[0]] + merge(xs[1:], ys)
    else:
        return [ys[0]] + merge(xs, ys[1:])

def safe_get_line():
    import sys
    try:
        return input()
    except EOFError:
        return ""

def main():
    a = safe_get_line()
    b = safe_get_line()
    result = merge(read_nums(a), read_nums(b))
    if result:
        print(" ".join(map(str, result)))

if __name__ == "__main__":
    main()
