package benchmark.p03_dedupe;

import java.io.*;
import java.util.*;

public class P03Dedupe {
    public static void main(String[] args) throws Exception {
        String line = new BufferedReader(new InputStreamReader(System.in)).readLine();
        if (line == null) line = "";

        Set<Integer> seen = new HashSet<>();
        StringBuilder result = new StringBuilder();

        for (String token : line.split("\\s+")) {
            if (token.isEmpty()) continue;
            
            int value = Integer.parseInt(token);
            if (seen.add(value)) {
                if (result.length() > 0) result.append(' ');
                result.append(value);
            }
        }

        if (result.length() > 0) System.out.println(result);
    }
}
