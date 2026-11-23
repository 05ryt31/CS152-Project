def stackvm():
    stack = []
    while True:
        cmd = raw_input()
        if cmd == "exit":
            break
        elif cmd.startswith("push"):
            stack.append(int(cmd.split()[1]))
        elif cmd == "pop":
            try:
                print stack.pop()
            except IndexError:
                print "Error"
        elif cmd == "add":
            try:
                stack.append(stack.pop() + stack.pop())
            except IndexError:
                print "Error"
        elif cmd == "mul":
            try:
                stack.append(stack.pop() * stack.pop())
            except IndexError:
                print "Error"
        elif cmd == "dup":
            try:
                stack.append(stack[-1])
            except IndexError:
                print "Error"
        elif cmd == "swap":
            try:
                stack[-1], stack[-2] = stack[-2], stack[-1]
            except IndexError:
                print "Error"
        elif cmd == "print":
            try:
                print stack[-1]
            except IndexError:
                print "Error"
 
if __name__ == "__main__":
    stackvm()
