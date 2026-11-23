from itertools import permutations
 
for s in sorted(''.join(p) for p in permutations('abc')):
    print(s)
