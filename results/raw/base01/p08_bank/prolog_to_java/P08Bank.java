package results.raw.base01.p08_bank.prolog_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class P08Bank {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String NLine = reader.readLine();
            int N = Integer.parseInt(NLine);
            int balance = commands(N, 0);
            System.exit(0);
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }

    private static int commands(int n, int balance) throws IOException {
        if (n == 0) return balance;
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String line = reader.readLine();
        String[] parts = line.split(" ");
        balance = command(parts, balance);
        return commands(n - 1, balance);
    }

    private static int command(String[] parts, int balance) {
        if ("deposit".equals(parts[0])) {
            int amount = Integer.parseInt(parts[1]);
            return balance + amount;
        } else if ("withdraw".equals(parts[0])) {
            int amount = Integer.parseInt(parts[1]);
            if (amount > balance) {
                System.err.println("error");
                return balance;
            }
            return balance - amount;
        } else if ("balance".equals(parts[0])) {
            System.out.println(balance);
            return balance;
        }
        return balance;
    }
}
