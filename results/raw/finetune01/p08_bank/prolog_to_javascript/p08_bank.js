var bank = {
    balance: 0,
    deposit: function(amount){
        this.balance += amount;
    },
    withdraw: function(amount){
        if(this.balance >= amount){
            this.balance -= amount;
        }else{
            console.log("Insufficient funds");
        }
    },
    getBalance: function(){
        return this.balance;
    }
};
 
bank.deposit(50);
bank.withdraw(30);
console.log(bank.getBalance());
