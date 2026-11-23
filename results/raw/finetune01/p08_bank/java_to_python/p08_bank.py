 
class BankAccount(object):
    def __init__(self):
        self.balance = 0
 
    def deposit(self, amount):
        self.balance += amount
 
    def withdraw(self, amount):
        if amount > self.balance:
            raise ValueError('Insufficient funds')
        self.balance -= amount
 
    def get_balance(self):
        return self.balance
 
if __name__ == '__main__':
    bank = BankAccount()
    while True:
        command = raw_input('> ')
        tokens = command.split()
        if len(tokens) != 2:
            print 'Invalid command'
            continue
        cmd = tokens[0]
        amt = int(tokens[1])
        try:
            if cmd == 'deposit':
                bank.deposit(amt)
            elif cmd == 'withdraw':
                bank.withdraw(amt)
            elif cmd == 'balance':
                print bank.get_balance()
            else:
                print 'Unknown command'
        except ValueError, e:
            print str(e)
 
