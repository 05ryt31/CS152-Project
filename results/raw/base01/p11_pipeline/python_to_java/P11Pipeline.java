package results.raw.base01.p11_pipeline.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class P11Pipeline {
    public static void main(String[] args) {
        List<Integer> values = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String line = reader.readLine();
            for (String token : line.split("\\s+")) {
                values.add(Integer.parseInt(token));
            }
            int k = Integer.parseInt(reader.readLine());
            for (int i = 0; i < k; i++) {
                String[] parts = reader.readLine().split("\\s+");
                values = applyStage(values, parts);
            }
            if (!values.isEmpty()) {
                System.out.println(String.join(" ", values.stream().map(String::valueOf).toArray(String[]::new)));
            } else {
                System.out.println(values.get(0));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static List<Integer> applyStage(List<Integer> values, String[] parts) {
        String kind = parts[0];
        String name = parts[1];
        if ("map".equals(kind)) {
            int amount = Integer.parseInt(parts[2]);
            List<Integer> result = new ArrayList<>();
            for (Integer v : values) {
                if ("add".equals(name)) {
                    result.add(v + amount);
                } else {
                    result.add(v * amount);
                }
            }
            return result;
        }
        if ("filter".equals(kind)) {
            List<Integer> result = new ArrayList<>();
            for (Integer v : values) {
                if (("even".equals(name) && v % 2 == 0) ||
                    ("odd".equals(name) && v % 2 != 0) ||
                    ("gt".equals(name) && v > Integer.parseInt(parts[2]))) {
                    result.add(v);
                }
            }
            return result;
        }
        // reduce
        if ("sum".equals(name)) {
            int total = 0;
            for (Integer v : values) {
                total += v;
            }
            return List.of(total);
        }
        if (values.isEmpty()) {
            return List.of(-1); // Assuming -1 is equivalent to "none"
        }
        int best = values.get(0);
        for (Integer v : values) {
            if (v > best) {
                best = v;
            }
        }
        return List.of(best);
    }
}
