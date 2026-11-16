package results.raw.base01.p09_stack_vm.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class P09StackVm {
    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int n = Integer.parseInt(reader.readLine());
        Stack<Integer> stack = new Stack<>();
        for (int i = 0; i < n; i++) {
            String[] parts = reader.readLine().split();
            String op = parts[0];
            switch (op) {
                case "push":
                    stack.push(Integer.parseInt(parts[1]));
                    break;
                case "pop":
                    if (stack.isEmpty()) {
                        System.out.println("error");
                    } else {
                        stack.pop();
                    }
                    break;
                case "add":
                case "mul":
                    if (stack.size() < 2) {
                        System.out.println("error");
                    } else {
                        int b = stack.pop();
                        int a = stack.pop();
                        if (op.equals("add")) {
                            stack.push(a + b);
                        } else {
                            stack.push(a * b);
                        }
                    }
                    break;
                case "dup":
                    if (stack.isEmpty()) {
                        System.out.println("error");
                    } else {
                        stack.push(stack.peek());
                    }
                    break;
                case "swap":
                    if (stack.size() < 2) {
                        System.out.println("error");
                    } else {
                        int temp = stack.pop();
                        stack.pop();
                        stack.push(temp);
                        stack.push(stack.pop());
                    }
                    break;
                case "print":
                    if (stack.isEmpty()) {
                        System.out.println("error");
                    } else {
                        System.out.println(stack.peek());
                    }
                    break;
            }
        }
    }
}
