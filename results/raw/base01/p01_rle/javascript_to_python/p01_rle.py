import sys

line = sys.stdin.read().strip()
result = ''

i = 0
while i < len(line):
    j = i
    while j < len(line) and line[j] == line[i]:
        j += 1
    result += line[i] + str(j - i)
    i = j

print(result)
