package results.raw.base01.p09_stack_vm.haskell_to_java;

import java.util.*;

public class P09StackVm {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        List<String> commands = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            commands.add(scanner.nextLine());
        }
        System.out.println(String.join("\n", runStack(commands)));
    }

    private static List<String> runStack(List<String> commands) {
        return new ArrayList<>(Arrays.asList(catMaybes(rawOutputs(commands))));
    }

    private static List<Optional<String>> rawOutputs(List<String> commands) {
        Stack<Integer> stack = new Stack<>();
        for (String command : commands) {
            Optional<String> output = apply(stack, command);
            if (output.isPresent()) {
                System.out.print(output.get() + "\n");
            }
        }
        return Collections.emptyList();
    }

    private static Optional<String> apply(Stack<Integer> stack, String command) {
        String[] parts = command.split(" ");
        if ("push".equals(parts[0])) {
            try {
                stack.push(Integer.parseInt(parts[1]));
                return Optional.empty();
            } catch (NumberFormatException e) {
                return Optional.of("error");
            }
        } else if ("pop".equals(parts[0])) {
            if (stack.isEmpty()) {
                return Optional.of("error");
            } else {
                stack.pop();
                return Optional.empty();
            }
        } else if ("add".equals(parts[0])) {
            if (stack.size() < 2) {
                return Optional.of("error");
            } else {
                int b = stack.pop();
                int a = stack.pop();
                stack.push(a + b);
                return Optional.empty();
            }
        } else if ("mul".equals(parts[0])) {
            if (stack.size() < 2) {
                return Optional.of("error");
            } else {
                int b = stack.pop();
                int a = stack.pop();
                stack.push(a * b);
                return Optional.empty();
            }
        } else if ("dup".equals(parts[0])) {
            if (stack.isEmpty()) {
                return Optional.of("error");
            } else {
                int a = stack.peek();
                stack.push(a);
                return Optional.empty();
            }
        } else if ("swap".equals(parts[0])) {
            if (stack.size() < 2) {
                return Optional.of("error");
            } else {
                int b = stack.pop();
                int a = stack.pop();
                stack.push(b);
                stack.push(a);
                return Optional.empty();
            }
        } else if ("print".equals(parts[0])) {
            if (stack.isEmpty()) {
                return Optional.of("error");
            } else {
                return Optional.of(String.valueOf(stack.peek()));
            }
        } else {
            return Optional.of("error");
        }
    }
}
