def is_balanced(s):
    brackets = {'(': ')', '[': ']', '{': '}'}
    openers = brackets.keys()
    closers = brackets.values()
    stack = []
    for c in s:
        if c in openers:
            stack.append(c)
        elif c in closers:
            if len(stack) == 0:
                return False
            if c != brackets[stack.pop()]:
                return False
    return len(stack) == 0
 
for s in ['(())', '(()', '({[]})', '({)}']:
    print "%s -> %s" % (s, is_balanced(s))
