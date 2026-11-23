 
var bank = {
    account: [],
    deposit: function(amount){
        this.account.push(amount);
    },
    withdraw: function(amount){
        var i;
        for(i=0; i < this.account.length; i++){
            if(this.account[i] >= amount){
                this.account.splice(i,1);
                return true;
            }
        }
        return false;
    },
    balance: function(){
        var total = 0;
        for(var i=0; i < this.account.length; i++){
            total += this.account[i];
        }
        return total;
    }
};
 
bank.deposit(50);
bank.withdraw(30);
bank.balance();
 
