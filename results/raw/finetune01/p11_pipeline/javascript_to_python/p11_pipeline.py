from functools import reduce
 
def pipeline(*funcs):
    def helper(arg):
        return reduce(lambda x, f: f(x), funcs, arg)
    return helper
 
def adder(n):
    return lambda x: n+x
 
def multiplier(n):
    return lambda x: n*x
 
def filter_odd():
    return lambda x: [i for i in x if i % 2 == 1]
 
def filter_even():
    return lambda x: [i for i in x if i % 2 == 0]
 
def filter_gt(n):
    return lambda x: [i for i in x if i > n]
 
def sum_(x):
    return sum(x)
 
def max_(x):
    try:
        return max(x)
    except ValueError:
        return "None"
 
def min_(x):
    try:
        return min(x)
    except ValueError:
        return "None"
 
if __name__ == '__main__':
    data = list(map(int,input("Enter numbers separated by space: ").strip().split()))
    k = int(input("Enter number of operations: "))
    ops = []
    for _ in range(k):
        op = input("Enter operation: ")
        if op.startswith("map"):
            _, type_, num = op.split()
            if type_ == "add":
                ops.append(adder(int(num)))
            elif type_ == "multiply":
                ops.append(multiplier(int(num)))
        elif op.startswith("filter"):
            _, type_, num = op.split()
            if type_ == "odd":
                ops.append(filter_odd())
            elif type_ == "even":
                ops.append(filter_even())
            elif type_ == "gt":
                ops.append(filter_gt(int(num)))
        elif op.startswith("reduce"):
            _, type_ = op.split()
            if type_ == "sum":
                ops.append(sum_)
            elif type_ == "max":
                ops.append(max_)
            elif type_ == "min":
                ops.append(min_)
    pipe = pipeline(*ops)
    print(pipe(data))
