import sys

def encode(chars):
    if not chars:
        return ""
    current = chars[0]
    count = 1
    out = []
    for char in chars[1:]:
        if char == current:
            count += 1
        else:
            out.append(current + str(count))
            current = char
            count = 1
    out.append(current + str(count))
    return ''.join(out)

line = input()
print(encode(line))
