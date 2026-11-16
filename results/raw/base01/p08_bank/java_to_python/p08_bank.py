import sys

def main():
    reader = sys.stdin
    n = int(next(reader))
    balance = 0

    for _ in range(n):
        parts = next(reader).strip().split()
        command = parts[0]
        amount = int(parts[1]) if len(parts) > 1 else None

        if command == "deposit":
            balance += amount
        elif command == "withdraw":
            if amount > balance:
                print("error")
            else:
                balance -= amount
        elif command == "balance":
            print(balance)

if __name__ == "__main__":
    main()
