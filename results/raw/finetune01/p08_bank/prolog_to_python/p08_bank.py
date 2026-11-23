 
class BankAccount(object):
    def __init__(self):
        self.balance = 0
 
    def deposit(self, amount):
        self.balance += amount
 
    def withdraw(self, amount):
        if amount > self.balance:
            raise ValueError('Insufficient balance')
        self.balance -= amount
 
    def get_balance(self):
        return self.balance
 
if __name__ == '__main__':
    bank = BankAccount()
    while True:
        cmd = raw_input('> ')
        args = cmd.split()
        if len(args) < 2:
            print 'Invalid command'
            continue
        cmd = args[0]
        arg = int(args[1])
        try:
            if cmd == 'deposit':
                bank.deposit(arg)
            elif cmd == 'withdraw':
                bank.withdraw(arg)
            elif cmd == 'balance':
                print bank.get_balance()
            else:
                print 'Unknown command'
        except ValueError, e:
            print str(e)
 
