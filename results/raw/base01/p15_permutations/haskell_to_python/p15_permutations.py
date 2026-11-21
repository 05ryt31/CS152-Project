from itertools import permutations

def main():
    line = input()
    perms = sorted([''.join(p) for p in permutations(line)])
    print('\n'.join(perms))

if __name__ == "__main__":
    main()
