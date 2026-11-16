package results.raw.base01.p11_pipeline.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class P11Pipeline {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String firstLine = reader.readLine();
            List<Integer> values = firstLine != null && !firstLine.trim().isEmpty() ?
                    Arrays.stream(firstLine.split("\\s+")).map(Integer::parseInt).collect(Collectors.toList()) :
                    List.of();
            int k = Integer.parseInt(reader.readLine());
            List<String[]> operations = new ArrayList<>();
            for (int i = 0; i < k; i++) {
                operations.add(reader.readLine().split("\\s+"));
            }

            List<Object> result = values;
            for (String[] operation : operations) {
                if ("map".equals(operation[0])) {
                    result = result.stream()
                            .map(x -> "add".equals(operation[1]) ? (Integer) x + Integer.parseInt(operation[2]) : (Integer) x * Integer.parseInt(operation[2]))
                            .collect(Collectors.toList());
                } else if ("filter".equals(operation[0])) {
                    result = result.stream()
                            .filter(x -> "even".equals(operation[1]) ? ((Integer) x) % 2 == 0 : "odd".equals(operation[1]) ? ((Integer) x) % 2 != 0 : ((Integer) x) > Integer.parseInt(operation[2]))
                            .collect(Collectors.toList());
                } else {
                    if ("sum".equals(operation[1])) {
                        result = result.stream().reduce(0, Integer::sum);
                    } else if (!result.isEmpty()) {
                        result = Collections.singletonList(Collections.max(result));
                    } else {
                        result = List.of("none");
                    }
                }
            }

            if (!(result instanceof List<?>)) {
                System.out.println(result);
            } else {
                System.out.println(((List<?>) result).stream().map(Object::toString).collect(Collectors.joining(" ")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
