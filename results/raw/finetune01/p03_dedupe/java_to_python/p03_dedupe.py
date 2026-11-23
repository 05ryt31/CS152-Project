>>> s = "1 2 3 4 5 6 7 8 9 10 1 2 3 4 5"
>>> print(" ".join(str(i) for i in set(int(x) for x in s.split())))
1 2 3 4 5 6 7 8 9 10 
>>> 
