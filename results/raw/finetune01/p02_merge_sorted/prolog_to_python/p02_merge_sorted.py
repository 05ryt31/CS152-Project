def merge(a,b):
    i,j = 0,0
    while i < len(a) and j < len(b):
        if a[i] <= b[j]:
            yield a[i]
            i += 1
        else:
            yield b[j]
            j += 1
    while i < len(a): yield a[i]; i += 1
    while j < len(b): yield b[j]; j += 1
 
if __name__ == '__main__':
    import sys
    a = list(map(int, sys.argv[1].split()))
    b = list(map(int, sys.argv[2].split()))
    print(list(merge(a,b)))
