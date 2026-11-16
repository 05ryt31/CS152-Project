import sys

def generate(prefix, remaining):
    if not remaining:
        print(''.join(prefix))
    else:
        for i in range(len(remaining)):
            generate(prefix + [remaining[i]], remaining[:i] + remaining[i+1:])

letters = sorted(sys.stdin.read().strip())
generate([], letters)
