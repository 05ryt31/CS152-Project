import sys

lines = sys.stdin.read().split('\n')
n = int(lines[0])

balance = 0
output = []
for i in range(n):
    command, amount = lines[i + 1].split()
    value = int(amount)
    if command == 'deposit':
        balance += value
    elif command == 'withdraw' and value > balance:
        output.append('error')
    elif command == 'withdraw':
        balance -= value
    else:
        output.append(str(balance))

if output:
    print('\n'.join(output))
