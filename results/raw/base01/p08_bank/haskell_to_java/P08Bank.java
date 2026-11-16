package results.raw.base01.p08_bank.haskell_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class P08Bank {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            int n = Integer.parseInt(reader.readLine());
            List<String> commands = new ArrayList<>();
            for (int i = 0; i < n; i++) {
                commands.add(reader.readLine());
            }
            System.out.println(runCommands(commands));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String runCommands(List<String> commands) {
        int balance = 0;
        StringBuilder result = new StringBuilder();
        for (String command : commands) {
            String[] parts = command.split(" ");
            switch (parts[0]) {
                case "deposit":
                    int depositAmount = Integer.parseInt(parts[1]);
                    if (depositAmount >= 0) {
                        balance += depositAmount;
                    }
                    break;
                case "withdraw":
                    int withdrawAmount = Integer.parseInt(parts[1]);
                    if (withdrawAmount >= 0 && withdrawAmount <= balance) {
                        balance -= withdrawAmount;
                    } else if (withdrawAmount > balance) {
                        result.append("error\n");
                    }
                    break;
                case "balance":
                    result.append(balance).append("\n");
                    break;
                default:
                    // Ignore unknown commands
                    break;
            }
        }
        return result.toString();
    }
}
