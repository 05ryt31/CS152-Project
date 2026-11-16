package results.raw.base01.p08_bank.scheme_to_java;

import java.util.Scanner;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class P08Bank {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new BufferedReader(new InputStreamReader(System.in)))) {
            int n = Integer.parseInt(scanner.nextLine());
            bank(n);
        } catch (IOException e) {
            System.err.println("Error reading input");
            System.exit(1);
        }
    }

    private static void bank(int n) {
        int balance = 0;
        for (int i = 0; i < n; i++) {
            String[] parts = scanner.nextLine().split("\\s+");
            String command = parts[0];
            switch (command) {
                case "deposit":
                    balance += Integer.parseInt(parts[1]);
                    break;
                case "withdraw":
                    int amount = Integer.parseInt(parts[1]);
                    if (amount > balance) {
                        System.out.println("error");
                    } else {
                        balance -= amount;
                    }
                    break;
                default:
                    System.out.println(balance);
                    break;
            }
        }
    }
}
