from itertools import groupby
 
def rle(s):
    return [[len(list(g)), k] for k,g in groupby(s)]
 
if __name__ == '__main__':
    s = 'aaabbcccc'
    print(rle(s))
