import java.util.*;
 
class Bank {
    private Map<String, Integer> accounts;
 
    public Bank() {
        this.accounts = new HashMap<>();
    }
 
    public void deposit(String name, int money) {
        if (!accounts.containsKey(name)) {
            accounts.put(name, 0);
        }
        accounts.put(name, accounts.get(name) + money);
    }
 
    public boolean withdraw(String name, int money) {
        if (accounts.containsKey(name) && accounts.get(name) >= money) {
            accounts.put(name, accounts.get(name) - money);
            return true;
        } else {
            System.err.println("Error");
            return false;
        }
    }
 
    public void balance(String name) {
        if (accounts.containsKey(name)) {
            System.out.println(accounts.get(name));
        } else {
            System.err.println("Error");
        }
    }
}
 
public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Bank bank = new Bank();
 
        while (scanner.hasNext()) {
            String[] tokens = scanner.nextLine().split("\\s+");
            switch (tokens[0]) {
                case "deposit":
                    bank.deposit(tokens[1], Integer.parseInt(tokens[2]));
                    break;
                case "withdraw":
                    bank.withdraw(tokens[1], Integer.parseInt(tokens[2]));
                    break;
                case "balance":
                    bank.balance(tokens[1]);
                    break;
            }
        }
    }
}
