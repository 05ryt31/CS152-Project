import sys


def main():
    n = int(sys.stdin.readline())
    balance = 0
    for _ in range(n):
        parts = sys.stdin.readline().split()
        command = parts[0]
        if command == "deposit":
            balance += int(parts[1])
        elif command == "withdraw":
            amount = int(parts[1])
            if amount > balance:
                print("error")
            else:
                balance -= amount
        elif command == "balance":
            print(balance)


main()
