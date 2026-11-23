from itertools import permutations
 
def perm(s):
    return sorted(''.join(x) for x in permutations(s))
 
if __name__ == '__main__':
    print(perm("abc"))
