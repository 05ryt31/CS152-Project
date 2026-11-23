from functools import reduce
 
def pipeline(*funcs):
    def helper(x, f): return f(x)
    return lambda x: reduce(helper, funcs, x)
 
if __name__ == '__main__':
    # example usage
    add5 = lambda x: x+5
    mul3 = lambda x: x*3
    even = lambda x: x % 2 == 0
    pipe = pipeline(add5, mul3, filter(even))
    print(pipe(range(10)))
