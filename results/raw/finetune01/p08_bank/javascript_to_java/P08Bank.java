import java.util.*;
 
class Bank {
    private double balance;
    private List<String> transactions;
 
    public Bank() {
        this.balance = 0;
        this.transactions = new ArrayList<>();
    }
 
    public void deposit(double amount) {
        this.balance += amount;
        this.transactions.add("Deposit " + amount);
    }
 
    public boolean withdraw(double amount) {
        if (this.balance >= amount) {
            this.balance -= amount;
            this.transactions.add("Withdrawal " + amount);
            return true;
        } else {
            this.transactions.add("Error");
            return false;
        }
    }
 
    public String getBalance() {
        return "Balance " + this.balance;
    }
 
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (String transaction : this.transactions) {
            sb.append(transaction).append("\n");
        }
        return sb.toString();
    }
}
 
public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int numTransactions = Integer.parseInt(scanner.nextLine());
        Bank bank = new Bank();
        for (int i = 0; i < numTransactions; i++) {
            String[] tokens = scanner.nextLine().split("\\s+");
            switch (tokens[0]) {
                case "deposit":
                    bank.deposit(Double.parseDouble(tokens[1]));
                    break;
                case "withdraw":
                    bank.withdraw(Double.parseDouble(tokens[1]));
                    break;
                default:
                    System.out.println("Unknown command");
                    break;
            }
        }
        System.out.println(bank.getBalance());
        System.out.print(bank);
    }
}
