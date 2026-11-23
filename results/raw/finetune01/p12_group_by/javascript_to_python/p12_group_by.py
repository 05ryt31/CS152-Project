from collections import defaultdict
 
def groupby(filename):
    with open(filename) as f:
        data = f.read().strip()
    lines = data.splitlines()
    num_lines = int(lines.pop(0))
    assert len(lines) == num_lines
    d = defaultdict(list)
    for line in lines:
        k, v = line.split()
        d[k].append(int(v))
    return d
 
if __name__ == '__main__':
    filename = 'p12_input.txt'
    d = groupby(filename)
    for k, v in sorted(d.items()):
        print(k, sum(v), len(v))
