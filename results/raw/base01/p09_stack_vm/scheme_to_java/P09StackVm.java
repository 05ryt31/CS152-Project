package results.raw.base01.p09_stack_vm.scheme_to_java;

import java.util.Scanner;
import java.util.ArrayList;
import java.util.List;

public class P09StackVm {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        List<Integer> stack = new ArrayList<>();
        
        for (int i = 0; i < n; i++) {
            String[] parts = scanner.nextLine().split(" ");
            String op = parts[0];
            
            switch (op) {
                case "push":
                    stack.add(Integer.parseInt(parts[1]));
                    break;
                case "pop":
                    if (stack.isEmpty()) {
                        System.out.println("error");
                    } else {
                        stack.remove(stack.size() - 1);
                    }
                    break;
                case "add":
                case "mul":
                    if (stack.size() < 2) {
                        System.out.println("error");
                    } else {
                        int b = stack.remove(stack.size() - 1);
                        int a = stack.remove(stack.size() - 1);
                        int result = (op.equals("add")) ? a + b : a * b;
                        stack.add(result);
                    }
                    break;
                case "dup":
                    if (stack.isEmpty()) {
                        System.out.println("error");
                    } else {
                        stack.add(stack.get(stack.size() - 1));
                    }
                    break;
                case "swap":
                    if (stack.size() < 2) {
                        System.out.println("error");
                    } else {
                        int temp = stack.remove(stack.size() - 1);
                        stack.set(stack.size() - 1, stack.remove(stack.size() - 1));
                        stack.add(temp);
                    }
                    break;
                default:
                    if (!stack.isEmpty()) {
                        System.out.println(stack.get(stack.size() - 1));
                    } else {
                        System.out.println("error");
                    }
                    break;
            }
        }
    }
}
