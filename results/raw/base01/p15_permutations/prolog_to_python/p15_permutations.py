import sys

def permutations(s):
    if len(s) == 1:
        return [s]
    perms = []
    for i in range(len(s)):
        char = s[i]
        remaining = s[:i] + s[i+1:]
        for perm in permutations(remaining):
            perms.append(char + perm)
    return perms

def main():
    input_str = sys.stdin.read().strip()
    sorted_chars = ''.join(sorted(input_str))
    unique_perms = list(set(permutations(sorted_chars)))
    for perm in unique_perms:
        print(perm)

if __name__ == "__main__":
    main()
