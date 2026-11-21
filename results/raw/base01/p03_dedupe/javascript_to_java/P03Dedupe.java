package results.raw.base01.p03_dedupe.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashSet;
import java.util.Set;

public class P03Dedupe {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String line = reader.readLine();
            Set<Integer> seen = new HashSet<>();
            StringBuilder result = new StringBuilder();

            if (line != null && !line.isEmpty()) {
                String[] tokens = line.split("\\s+");
                for (String token : tokens) {
                    int value = Integer.parseInt(token);
                    if (!seen.contains(value)) {
                        seen.add(value);
                        if (result.length() > 0) {
                            result.append(" ");
                        }
                        result.append(value);
                    }
                }
            }

            System.out.println(result.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
