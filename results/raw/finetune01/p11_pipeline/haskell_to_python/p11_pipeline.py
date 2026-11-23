from functools import reduce
 
def pipeline(values, *stages):
    if len(stages) == 0:
        return values
    elif len(stages) == 1:
        return eval(' '.join(stages[0].split()[::-1]) + ' values')
    else:
        return eval('pipeline({}, {})'.format(
            eval(' '.join(stages[0].split()[::-1]) + ' values'),
            ' '.join(stages[1:])
        ))
 
if __name__ == '__main__':
    print(pipeline([2, 5, 8], 'map mul 2', 'filter gt 7'))
    print(pipeline([2, 5, 8], 'map add 2', 'filter gt 7'))
    print(pipeline([2, 5, 8], 'map mul 2', 'filter gt 7', 'reduce sum'))
    print(pipeline([], 'map mul 2', 'filter gt 7'))
    print(pipeline([2, 5, 8], 'map mul 2', 'filter gt 7', 'reduce max'))
    print(pipeline([2, 5, 8], 'map mul 2', 'filter gt 7', 'reduce min'))
    print(pipeline([2, 5, 8], 'map mul 2', 'filter gt 7', 'reduce max', 'map add 1'))
