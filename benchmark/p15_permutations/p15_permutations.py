import sys


def generate(letters, used, current, out):
    if len(current) == len(letters):
        out.append("".join(current))
        return
    for i in range(len(letters)):
        if not used[i]:
            used[i] = True
            current.append(letters[i])
            generate(letters, used, current, out)
            current.pop()
            used[i] = False


def main():
    letters = sorted(sys.stdin.readline().strip())
    results = []
    generate(letters, [False] * len(letters), [], results)
    for word in results:
        print(word)


main()
