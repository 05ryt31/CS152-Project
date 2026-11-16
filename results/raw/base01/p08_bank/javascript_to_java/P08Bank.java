package results.raw.base01.p08_bank.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class P08Bank {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            List<String> lines = new ArrayList<>();
            String line;
            while ((line = reader.readLine()) != null) {
                lines.add(line);
            }

            int n = Integer.parseInt(lines.get(0));
            long balance = 0;
            List<String> output = new ArrayList<>();

            for (int i = 0; i < n; i++) {
                String[] parts = lines.get(i + 1).split("\\s+");
                String command = parts[0];
                long amount = Long.parseLong(parts[1]);

                if ("deposit".equals(command)) {
                    balance += amount;
                } else if ("withdraw".equals(command) && amount > balance) {
                    output.add("error");
                } else if ("withdraw".equals(command)) {
                    balance -= amount;
                } else {
                    output.add(Long.toString(balance));
                }
            }

            if (!output.isEmpty()) {
                System.out.println(String.join("\n", output));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
