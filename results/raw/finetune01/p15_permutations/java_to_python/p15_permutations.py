from itertools import permutations
 
for p in sorted(permutations('abc')):
	print(''.join(p))
