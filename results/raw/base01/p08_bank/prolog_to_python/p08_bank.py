import sys

def p08_bank():
    n_line = input().strip()
    n = int(n_line)
    commands(n, 0)

def commands(n, balance):
    if n == 0:
        return
    line = input().strip()
    parts = line.split(" ")
    new_balance = command(parts, balance)
    commands(n - 1, new_balance)

def command(parts, balance):
    if parts[0] == "deposit":
        amount = int(parts[1])
        return balance + amount
    elif parts[0] == "withdraw":
        amount = int(parts[1])
        if amount > balance:
            print("error")
            return balance
        else:
            return balance - amount
    elif parts[0] == "balance":
        print(balance)
        return balance

if __name__ == "__main__":
    p08_bank()
