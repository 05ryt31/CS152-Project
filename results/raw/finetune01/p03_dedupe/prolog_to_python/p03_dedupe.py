def dedupe(nums):
    return list(set(nums))
 
if __name__ == '__main__':
    nums = [1,2,3,4,5,6,7,8,9,10]
    print(dedupe(nums))
