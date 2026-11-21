import sys

def main():
    line = sys.stdin.readline().strip()
    expression = eval(line)
    print(expression)

if __name__ == "__main__":
    main()
