package benchmark.p08_bank;

import java.io.*;

public class P08Bank {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int n = Integer.parseInt(reader.readLine());
        int balance = 0;

        for (int i = 0; i < n; i++) {
            String[] parts = reader.readLine().split("\\s+");

            if (parts[0].equals("deposit")) balance += Integer.parseInt(parts[1]);
            else if (parts[0].equals("withdraw")) {
                int amount = Integer.parseInt(parts[1]);
                if (amount > balance) System.out.println("error");
                else balance -= amount;
            } else if (parts[0].equals("balance")) System.out.println(balance);
        }
    }
}
