from itertools import permutations
 
def permute(s):
    return [''.join(p) for p in permutations(s)]
 
if __name__ == '__main__':
    print(permute('abc'))
