package results.raw.base01.p03_dedupe.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashSet;
import java.util.Set;

public class P03Dedupe {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String line = reader.readLine();
            Set<Integer> seen = new HashSet<>();
            StringBuilder unique = new StringBuilder();
            for (String token : line.split()) {
                int value = Integer.parseInt(token);
                if (!seen.contains(value)) {
                    seen.add(value);
                    if (unique.length() > 0) {
                        unique.append(" ");
                    }
                    unique.append(value);
                }
            }
            if (unique.length() > 0) {
                System.out.println(unique.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
