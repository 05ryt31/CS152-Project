def bank():
    balance = 0
    while True:
        cmd = raw_input("Deposit, Withdraw, Balance, Quit? ")
        if cmd == 'Quit':
            break
        elif cmd == 'Balance':
            print balance
        elif cmd == 'Deposit':
            amt = int(raw_input('How much? '))
            balance += amt
        elif cmd == 'Withdraw':
            amt = int(raw_input('How much? '))
            if amt > balance:
                print 'Insufficient funds'
            else:
                balance -= amt
 
bank()
