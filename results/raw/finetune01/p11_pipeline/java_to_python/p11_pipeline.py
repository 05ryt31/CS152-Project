from functools import reduce
 
def pipeline(*funcs):
    def helper(x, f): return f(x)
    return reduce(helper, funcs)
 
if __name__ == '__main__':
    # test data
    nums = [1, 2, 3, 4, 5, 6]
    add2 = lambda x: x + 2
    mul3 = lambda x: x * 3
    is_odd = lambda x: x % 2 == 1
    is_even = lambda x: x % 2 == 0
    gt_3 = lambda x: x > 3
    sum_nums = lambda xs: sum(xs)
    max_num = lambda xs: max(xs)
    min_num = lambda xs: min(xs)
    none = lambda xs: 'None'
 
    # create some pipelines
    p1 = pipeline(add2, mul3)
    p2 = pipeline(is_odd, filter)
    p3 = pipeline(is_even, filter)
    p4 = pipeline(gt_3, filter)
    p5 = pipeline(sum_nums)
    p6 = pipeline(max_num)
    p7 = pipeline(min_num)
    p8 = pipeline(none)
 
    # apply the pipelines to the test data
    print(p1(nums))
    print(p2(nums))
    print(p3(nums))
    print(p4(nums))
    print(p5(nums))
    print(p6(nums))
    print(p7(nums))
    print(p8(nums))
