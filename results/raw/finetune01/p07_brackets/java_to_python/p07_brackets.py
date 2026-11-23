def is_balanced(s):
    brackets = {'(': ')', '[': ']', '{': '}', '<': '>'}
    openers = brackets.keys()
    closers = brackets.values()
    stack = []
    for char in s:
        if char in openers:
            stack.append(char)
        elif char in closers:
            if len(stack) == 0:
                return False
            opener = stack.pop()
            if brackets[opener] != char:
                return False
    return len(stack) == 0
 
if __name__ == '__main__':
    print(is_balanced('([]{})'))
    print(is_balanced('([)]'))
    print(is_balanced('(}'))
    print(is_balanced('{[()]}'))
    print(is_balanced('(({{[[(())]]}}))'))
    print(is_balanced('(()'))
