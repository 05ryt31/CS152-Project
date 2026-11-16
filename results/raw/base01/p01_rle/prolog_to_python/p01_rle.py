import sys

def read_line():
    return sys.stdin.readline().rstrip()

def write_line(line):
    print(line, end='')

def encode(chars):
    if not chars:
        return []
    c = chars[0]
    count = sum(1 for _ in chars if _ == c)
    return [[c, str(count)]] + encode(chars[count:])

def main():
    line = read_line()
    encoded = encode(list(line))
    write_line(''.join(map(''.join, encoded)))
    sys.stdout.flush()

if __name__ == "__main__":
    main()
