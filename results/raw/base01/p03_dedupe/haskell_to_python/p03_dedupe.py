import sys

def read_nums(s):
    return list(map(int, s.split()))

def unique(nums):
    seen = set()
    result = []
    for num in nums:
        if num not in seen:
            result.append(num)
            seen.add(num)
    return result

def safe_get_line():
    try:
        return input()
    except EOFError:
        return ""

def main():
    line = safe_get_line()
    result = unique(read_nums(line))
    if result:
        print(" ".join(map(str, result)))

if __name__ == "__main__":
    main()
