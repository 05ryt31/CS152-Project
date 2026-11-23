def stackvm():
    """Stack VM"""
 
    # get the input
    n = int(input("Enter the number of instructions: "))
    ins = []
    for i in range(n):
        ins.append(input("Enter instruction {}: ".format(i+1)))
 
    # create the stack
    stack = []
 
    # process each instruction
    for i in ins:
        if i == 'pop':
            try:
                stack.pop()
            except IndexError:
                print('Error')
        elif i == 'add':
            try:
                stack[-2] += stack[-1]
                stack.pop()
            except IndexError:
                print('Error')
        elif i == 'mul':
            try:
                stack[-2] *= stack[-1]
                stack.pop()
            except IndexError:
                print('Error')
        elif i == 'dup':
            try:
                stack.append(stack[-1])
            except IndexError:
                print('Error')
        elif i == 'swap':
            try:
                stack[-2], stack[-1] = stack[-1], stack[-2]
            except IndexError:
                print('Error')
        elif i == 'print':
            try:
                print(stack[-1])
            except IndexError:
                print('Error')
        else:
            try:
                stack.append(int(i))
            except ValueError:
                print('Error')
 
stackvm()
