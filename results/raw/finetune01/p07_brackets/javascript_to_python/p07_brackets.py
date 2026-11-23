def is_balanced(s):
    brackets = {'(':')','{':'}','[':']'}
    openers = brackets.keys()
    closers = brackets.values()
    stack = []
    for c in s:
        if c in openers:
            stack.append(c)
        elif c in closers:
            if len(stack)==0 or brackets[stack.pop()]!=c:
                return False
    return len(stack)==0
 
if __name__ == '__main__':
    assert is_balanced('([]{})')
    assert not is_balanced('([)]')
    assert is_balanced('')
    assert not is_balanced('{[(])}')
    assert is_balanced('((()))')
    assert not is_balanced('(()')
