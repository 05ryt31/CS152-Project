 
class BankAccount(object):
    def __init__(self):
        self.balance = 0
 
    def deposit(self, amount):
        self.balance += amount
 
    def withdraw(self, amount):
        if amount > self.balance:
            raise ValueError("Insufficient funds")
        self.balance -= amount
 
    def get_balance(self):
        return self.balance
 
 
if __name__ == '__main__':
    bank = BankAccount()
    print(bank.get_balance())
    bank.deposit(25)
    print(bank.get_balance())
    try:
        bank.withdraw(30)
    except ValueError as e:
        print(e)
    bank.withdraw(10)
    print(bank.get_balance())
 
