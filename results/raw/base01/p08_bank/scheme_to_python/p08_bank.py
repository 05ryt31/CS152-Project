import sys

def bank(n):
    balance = 0
    for _ in range(n):
        parts = input().split()
        command = parts[0]
        if command == "deposit":
            balance += int(parts[1])
        elif command == "withdraw":
            amount = int(parts[1])
            if amount > balance:
                print("error")
            else:
                balance -= amount
        else:
            print(balance)

n = int(input())
bank(n)
