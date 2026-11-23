from collections import defaultdict
 
def groupby(iterable):
    groups = defaultdict(list)
    for item in iterable:
        groups[item[0]].append(item[1])
    return groups
 
if __name__ == '__main__':
    data = [('a', 1), ('b', 2), ('a', 3), ('c', 4), ('b', 5)]
    grouped = groupby(data)
    for k, v in sorted(grouped.items()):
        print(k, sum(v), len(v))
