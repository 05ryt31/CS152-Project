var bank = {
    deposit: function(amount){
        this.balance += amount;
    },
    withdraw: function(amount){
        if(this.balance >= amount){
            this.balance -= amount;
        }else{
            console.log('Insufficient funds');
        }
    },
    getBalance: function(){
        return this.balance;
    },
    init: function(){
        this.balance = 0;
    }
};
 
bank.init();
bank.deposit(50);
bank.withdraw(30);
bank.withdraw(40);
bank.deposit(100);
console.log(bank.getBalance()); // 90
