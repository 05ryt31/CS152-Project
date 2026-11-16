package results.raw.base01.p08_bank.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class P08Bank {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            int n = Integer.parseInt(reader.readLine());
            int balance = 0;
            for (int i = 0; i < n; i++) {
                String[] parts = reader.readLine().split();
                String command = parts[0];
                if ("deposit".equals(command)) {
                    balance += Integer.parseInt(parts[1]);
                } else if ("withdraw".equals(command)) {
                    int amount = Integer.parseInt(parts[1]);
                    if (amount > balance) {
                        System.out.println("error");
                    } else {
                        balance -= amount;
                    }
                } else if ("balance".equals(command)) {
                    System.out.println(balance);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
