import sys

def remove_first(value, values):
    if not values:
        return []
    if value == values[0]:
        return values[1:]
    return [values[0]] + remove_first(value, values[1:])

def generate(prefix, remaining):
    if not remaining:
        print(''.join(reversed(prefix)))
    else:
        for letter in remaining:
            new_remaining = remove_first(letter, remaining)
            generate([letter] + prefix, new_remaining)

letters = sorted(list(sys.stdin.readline().strip()))
generate([], letters)
