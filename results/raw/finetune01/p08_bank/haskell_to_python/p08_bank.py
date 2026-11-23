 
class BankAccount(object):
    def __init__(self):
        self.balance = 0
 
    def deposit(self, amount):
        self.balance += amount
 
    def withdraw(self, amount):
        if amount > self.balance:
            raise ValueError('Insufficient funds')
        self.balance -= amount
 
    def show_balance(self):
        return self.balance
 
if __name__ == '__main__':
    bank = BankAccount()
    while True:
        command = raw_input("Enter 'deposit', 'withdraw' or 'balance': ")
        if command == 'deposit':
            amount = int(raw_input("Enter amount to deposit: "))
            bank.deposit(amount)
        elif command == 'withdraw':
            amount = int(raw_input("Enter amount to withdraw: "))
            try:
                bank.withdraw(amount)
            except ValueError:
                print "Error: Insufficient funds"
        elif command == 'balance':
            print "Balance is %i" % bank.show_balance()
        else:
            break
 
