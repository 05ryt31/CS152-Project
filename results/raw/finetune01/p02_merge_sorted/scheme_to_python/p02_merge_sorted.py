def merge(a,b):
    i = j = 0
    c = []
    while i < len(a) and j < len(b):
        if a[i] <= b[j]:
            c.append(a[i])
            i += 1
        else:
            c.append(b[j])
            j += 1
    return c + a[i:] + b[j:]
 
a = [1,3,5,7]
b = [2,4,6,8]
print(merge(a,b))
