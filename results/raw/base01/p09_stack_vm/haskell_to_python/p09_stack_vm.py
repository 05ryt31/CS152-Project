import sys

def step(stack, command):
    if command == "pop":
        if not stack:
            return stack, "error"
        else:
            return stack[1:], None
    elif command == "add":
        if len(stack) < 2:
            return stack, "error"
        else:
            return [stack[0] + stack[1]] + stack[2:], None
    elif command == "mul":
        if len(stack) < 2:
            return stack, "error"
        else:
            return [stack[0] * stack[1]] + stack[2:], None
    elif command == "dup":
        if not stack:
            return stack, "error"
        else:
            return [stack[0]] + stack, None
    elif command == "swap":
        if len(stack) < 2:
            return stack, "error"
        else:
            return [stack[1], stack[0]] + stack[2:], None
    elif command == "print":
        if not stack:
            return stack, "error"
        else:
            return stack, str(stack[0])
    else:
        return stack, None

def run_stack(commands):
    stack = []
    outputs = []
    for command in commands:
        _, output = step(stack, command)
        if output is not None:
            outputs.append(output)
    return outputs

def main():
    n = int(input())
    commands = [input().strip() for _ in range(n)]
    print("\n".join(run_stack(commands)))

if __name__ == "__main__":
    main()
