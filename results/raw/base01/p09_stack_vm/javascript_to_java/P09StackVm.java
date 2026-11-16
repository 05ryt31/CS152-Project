package results.raw.base01.p09_stack_vm.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class P09StackVm {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            List<String> lines = new ArrayList<>();
            String line;
            while ((line = reader.readLine()) != null) {
                lines.add(line);
            }
            int n = Integer.parseInt(lines.get(0));
            List<Integer> stack = new ArrayList<>();
            List<String> output = new ArrayList<>();
            for (int i = 0; i < n; i++) {
                String[] parts = lines.get(i + 1).split("\\s+");
                String op = parts[0];
                if ("push".equals(op)) {
                    stack.add(Integer.parseInt(parts[1]));
                } else if ("pop".equals(op)) {
                    if (stack.isEmpty()) {
                        output.add("error");
                    } else {
                        stack.remove(stack.size() - 1);
                    }
                } else if ("add".equals(op) || "mul".equals(op)) {
                    if (stack.size() < 2) {
                        output.add("error");
                    } else {
                        int b = stack.remove(stack.size() - 1);
                        int a = stack.remove(stack.size() - 1);
                        stack.add("add".equals(op) ? a + b : a * b);
                    }
                } else if ("dup".equals(op)) {
                    if (stack.isEmpty()) {
                        output.add("error");
                    } else {
                        stack.add(stack.get(stack.size() - 1));
                    }
                } else if ("swap".equals(op)) {
                    if (stack.size() < 2) {
                        output.add("error");
                    } else {
                        int top = stack.size() - 1;
                        int temp = stack.get(top);
                        stack.set(top, stack.get(top - 1));
                        stack.set(top - 1, temp);
                    }
                } else {
                    output.add(stack.isEmpty() ? "error" : String.valueOf(stack.get(stack.size() - 1)));
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
