import java.util.*;
 
class Bank {
    private int balance;
 
    public Bank(int initialBalance) {
        this.balance = initialBalance;
    }
 
    public boolean deposit(int amount) {
        if (amount < 0) return false;
        balance += amount;
        return true;
    }
 
    public boolean withdraw(int amount) {
        if (amount < 0 || amount > balance) return false;
        balance -= amount;
        return true;
    }
 
    public int getBalance() {
        return balance;
    }
}
 
public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Initial bank balance? ");
        int initialBalance = Integer.parseInt(scanner.nextLine());
        Bank bank = new Bank(initialBalance);
 
        while (true) {
            System.out.print("Command? ");
            String command = scanner.nextLine();
            if ("quit".equals(command)) break;
            String[] parts = command.split("\\s+");
            switch (parts[0]) {
                case "deposit":
                    try {
                        int amount = Integer.parseInt(parts[1]);
                        if (!bank.deposit(amount)) {
                            System.out.println("Deposit failed.");
                        } else {
                            System.out.println("New balance is " + bank.getBalance());
                        }
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid number format.");
                    }
                    break;
                case "withdraw":
                    try {
                        int amount = Integer.parseInt(parts[1]);
                        if (!bank.withdraw(amount)) {
                            System.out.println("Withdrawal failed.");
                        } else {
                            System.out.println("New balance is " + bank.getBalance());
                        }
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid number format.");
                    }
                    break;
                case "balance":
                    System.out.println("Current balance is " + bank.getBalance());
                    break;
                default:
                    System.out.println("Unknown command.");
            }
        }
    }
}
