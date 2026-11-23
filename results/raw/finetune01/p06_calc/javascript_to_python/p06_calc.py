def calc(s):
    s = s.replace(' ', '')
    stack = []
    i = len(s)-1
    while i >= 0:
        c = s[i]
        if c == ')':
            stack.append(c)
        elif c.isdigit():
            j = i
            while j > 0 and s[j-1].isdigit():
                j -= 1
            stack.append(int(s[j:i+1]))
            i = j-1
        elif c == '(':
            count = 1
            while count != 0:
                i -= 1
                if s[i] == ')': count += 1
                if s[i] == '(': count -= 1
            stack.append(calc(s[i+1:-1]))
        elif c in '+-*':
            op = c
            i -= 1
            num2 = stack.pop()
            while isinstance(stack[-1], str):
                op2 = stack.pop()
                num1 = stack.pop()
                if op2 == '*' and op == '+':
                    num1 *= num2
                    num2 = num1
                else:
                    num1 = eval(str(num1)+op2+str(num2))
                op = op2
            stack.append(eval(str(stack.pop())+op+str(num2)))
    return stack[0]
 
if __name__ == '__main__':
    print(calc('(1+(2*3))+(4*(5+(6*7)))'))
