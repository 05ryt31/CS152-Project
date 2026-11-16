import sys

def nums(line):
    if line == "":
        return []
    parts = line.split()
    if len(parts) == 0:
        return []
    return list(map(int, parts))

def unique(nums, seen, result):
    if not nums:
        return result
    x = nums[0]
    if x in seen:
        return unique(nums[1:], seen, result)
    return unique(nums[1:], seen + [x], result + [x])

def print_nums(nums):
    print(' '.join(map(str, nums)))

def main():
    line = sys.stdin.readline().strip()
    ns = nums(line)
    result = unique(ns, [], [])
    print_nums(result)

if __name__ == "__main__":
    main()
