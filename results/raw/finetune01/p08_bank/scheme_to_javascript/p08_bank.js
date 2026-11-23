 
var bank = {
    balance: 0,
    deposit: function(amount){
        this.balance += amount;
    },
    withdraw: function(amount){
        if(this.balance >= amount){
            this.balance -= amount;
        }else{
            console.log("Error");
        }
    },
    getBalance: function(){
        return this.balance;
    }
};
 
// Test
bank.deposit(5);
bank.withdraw(3);
console.log(bank.getBalance());
 
