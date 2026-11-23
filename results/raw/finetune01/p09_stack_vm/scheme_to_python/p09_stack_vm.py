def stack_vm():
    stack = []
    while True:
        cmd = input("Enter command: ")
        if cmd == "":
            break
        elif cmd.startswith("push"):
            try:
                stack.append(int(cmd.split()[1]))
            except ValueError:
                print("Error: Invalid number.")
        elif cmd == "pop":
            try:
                stack.pop()
            except IndexError:
                print("Error: Stack is empty.")
        elif cmd == "add":
            try:
                stack[-2] += stack[-1]
                del stack[-1]
            except IndexError:
                print("Error: Not enough numbers in stack.")
        elif cmd == "mul":
            try:
                stack[-2] *= stack[-1]
                del stack[-1]
            except IndexError:
                print("Error: Not enough numbers in stack.")
        elif cmd == "dup":
            try:
                stack.append(stack[-1])
            except IndexError:
                print("Error: Stack is empty.")
        elif cmd == "swap":
            try:
                stack[-2], stack[-1] = stack[-1], stack[-2]
            except IndexError:
                print("Error: Not enough numbers in stack.")
        else:
            try:
                print(stack[-1])
            except IndexError:
                print("Error: Stack is empty.")
 
if __name__ == "__main__":
    stack_vm()
