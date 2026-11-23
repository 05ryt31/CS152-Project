from itertools import groupby
 
def rle(s):
    return ''.join('%i%s' % (len(list(g)), k) for k, g in groupby(s))
 
if __name__ == '__main__':
    print(rle('AAAABBBCCDAA'))
