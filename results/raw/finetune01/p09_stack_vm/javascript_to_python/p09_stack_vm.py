def main():
    # read in the number of commands
    num_commands = int(input())
 
    # create a list of lists where each sublist is a command
    commands = []
    for _ in range(num_commands):
        commands.append(input().strip().split())
 
    # create a stack
    stack = []
 
    # process each command
    for cmd in commands:
        if cmd[0] == "push":
            stack.append(int(cmd[1]))
        elif cmd[0] == "pop":
            try:
                stack.pop()
            except IndexError:
                print("ERROR")
        elif cmd[0] == "add":
            try:
                stack[-2] += stack[-1]
                stack.pop()
            except IndexError:
                print("ERROR")
        elif cmd[0] == "mul":
            try:
                stack[-2] *= stack[-1]
                stack.pop()
            except IndexError:
                print("ERROR")
        elif cmd[0] == "dup":
            try:
                stack.append(stack[-1])
            except IndexError:
                print("ERROR")
        elif cmd[0] == "swap":
            try:
                stack[-2], stack[-1] = stack[-1], stack[-2]
            except IndexError:
                print("ERROR")
        elif cmd[0] == "out":
            try:
                print(stack[-1])
            except IndexError:
                print("ERROR")
 
if __name__ == "__main__":
    main()
