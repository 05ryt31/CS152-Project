import sys

def main():
    line = sys.stdin.read().strip()
    result = ''.join([char + str(len(list(group))) for char, group in itertools.groupby(line)])
    print(result)

if __name__ == "__main__":
    import itertools
    main()
