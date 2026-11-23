from collections import defaultdict
 
def groupby(iterable):
    d = defaultdict(list)
    for k,v in iterable:
        d[k].append(v)
    return d
 
if __name__ == '__main__':
    data = [('a', 1), ('b', 2), ('a', 3), ('c', 4), ('b', 5)]
    print(groupby(data))
