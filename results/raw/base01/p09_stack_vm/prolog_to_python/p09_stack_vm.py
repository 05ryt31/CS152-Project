import sys

def read_line():
    return sys.stdin.readline().strip()

def number_string(s):
    return int(s)

def run(n, stack):
    if n == 0:
        return stack
    else:
        line = read_line()
        parts = line.split(" ")
        new_stack = execute(parts, stack)
        return run(n - 1, new_stack)

def execute(parts, stack):
    op = parts[0]
    if op == "push":
        x = number_string(parts[1])
        return [x] + stack
    elif op == "pop":
        if len(stack) == 0:
            print("error")
            return []
        else:
            return stack[1:]
    elif op in ["add", "mul"]:
        if len(stack) < 2:
            print("error")
            return stack
        else:
            b, a = stack[:2]
            if op == "add":
                return [(a + b)] + stack[2:]
            else:
                return [(a * b)] + stack[2:]
    elif op == "dup":
        if len(stack) == 0:
            print("error")
            return []
        else:
            x = stack[0]
            return [x, x] + stack[1:]
    elif op == "swap":
        if len(stack) < 2:
            print("error")
            return stack
        else:
            a, b = stack[:2]
            return [b, a] + stack[2:]
    elif op == "print":
        if len(stack) == 0:
            print("error")
            return []
        else:
            x = stack[0]
            print(x)
            return stack[1:]

if __name__ == "__main__":
    n_line = read_line()
    n = number_string(n_line)
    final_stack = run(n, [])
