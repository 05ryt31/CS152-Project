package results.raw.base01.p09_stack_vm.prolog_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

public class P09StackVm {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(new BufferedReader(new InputStreamReader(System.in)));
        int n = Integer.parseInt(scanner.nextLine());
        List<Integer> stack = new ArrayList<>();
        try {
            run(n, stack);
        } catch (Exception e) {
            System.out.println("error");
        }
        System.exit(0);
    }

    private static void run(int n, List<Integer> stack) throws Exception {
        if (n == 0) return;
        String line = System.console().readLine();
        List<String> parts = Arrays.asList(line.split(" "));
        execute(parts, stack);
        run(n - 1, stack);
    }

    private static void execute(List<String> parts, List<Integer> stack) throws Exception {
        switch (parts.get(0)) {
            case "push":
                stack.add(Integer.parseInt(parts.get(1)));
                break;
            case "pop":
                if (stack.isEmpty()) throw new Exception();
                stack.remove(stack.size() - 1);
                break;
            case "add":
            case "mul":
                if (stack.size() < 2) throw new Exception();
                int b = stack.remove(stack.size() - 1);
                int a = stack.remove(stack.size() - 1);
                if ("add".equals(parts.get(0))) stack.add(a + b);
                else stack.add(a * b);
                break;
            case "dup":
                if (stack.isEmpty()) throw new Exception();
                stack.add(stack.get(stack.size() - 1));
                break;
            case "swap":
                if (stack.size() < 2) throw new Exception();
                int temp = stack.remove(stack.size() - 1);
                stack.set(stack.size() - 1, stack.remove(stack.size() - 1));
                stack.add(temp);
                break;
            case "print":
                if (stack.isEmpty()) throw new Exception();
                System.out.println(stack.get(stack.size() - 1));
                break;
            default:
                throw new Exception();
        }
    }
}
