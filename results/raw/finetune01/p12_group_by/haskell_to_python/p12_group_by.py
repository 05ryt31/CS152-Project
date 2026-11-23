from collections import defaultdict
 
def groupby(filename):
    d = defaultdict(list)
    with open(filename) as f:
        for line in f:
            k,v = line.split()
            d[k].append(int(v))
    return d
 
if __name__ == '__main__':
    filename = 'groupby.txt'
    d = groupby(filename)
    print('Sum:')
    for k, v in sorted(d.items()):
        print(k, sum(v))
    print('\nCount:')
    for k, v in sorted(d.items()):
        print(k, len(v))
