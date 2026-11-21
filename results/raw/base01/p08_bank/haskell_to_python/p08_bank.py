import sys

def run_commands(commands):
    balance = 0
    raw_outputs = []
    for line in commands:
        parts = line.split()
        if parts[0] == "deposit":
            amt = int(parts[1])
            if amt >= 0:
                balance += amt
        elif parts[0] == "withdraw":
            amt = int(parts[1])
            if amt >= 0:
                if amt > balance:
                    raw_outputs.append("error")
                else:
                    balance -= amt
        elif parts[0] == "balance":
            raw_outputs.append(str(balance))
    return raw_outputs

def main():
    n = int(input())
    commands = [input() for _ in range(n)]
    outputs = run_commands(commands)
    print("\n".join(outputs))

if __name__ == "__main__":
    main()
