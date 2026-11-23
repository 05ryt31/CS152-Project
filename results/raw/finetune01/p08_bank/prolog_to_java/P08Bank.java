import java.util.*;
 
public class Bank {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int balance = 0;
        while (sc.hasNext()) {
            String cmd = sc.next();
            if ("balance".equals(cmd)) {
                System.out.println(balance);
            } else if ("deposit".equals(cmd)) {
                balance += Integer.parseInt(sc.next());
            } else if ("withdraw".equals(cmd)) {
                int amount = Integer.parseInt(sc.next());
                if (amount <= balance) {
                    balance -= amount;
                } else {
                    System.err.println("error");
                }
            }
        }
    }
}
