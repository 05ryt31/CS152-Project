import java.util.*;
 
public class StackVM {
 
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the number of instructions:");
        int numInstructions = Integer.parseInt(scanner.nextLine());
        String[] instructions = new String[numInstructions];
        for (int i = 0; i < numInstructions; i++) {
            instructions[i] = scanner.nextLine();
        }
        Stack<Integer> stack = new Stack<>();
        for (String instruction : instructions) {
            String[] parts = instruction.split("\\s+");
            switch (parts[0]) {
                case "push":
                    stack.push(Integer.parseInt(parts[1]));
                    break;
                case "pop":
                    if (!stack.isEmpty()) {
                        stack.pop();
                    } else {
                        System.err.println("Error: pop from empty stack");
                    }
                    break;
                case "add":
                    if (stack.size() >= 2) {
                        stack.push(stack.pop() + stack.pop());
                    } else {
                        System.err.println("Error: add requires at least two elements in stack");
                    }
                    break;
                case "mul":
                    if (stack.size() >= 2) {
                        stack.push(stack.pop() * stack.pop());
                    } else {
                        System.err.println("Error: mul requires at least two elements in stack");
                    }
                    break;
                case "dup":
                    if (!stack.isEmpty()) {
                        stack.push(stack.peek());
                    } else {
                        System.err.println("Error: dup requires at least one element in stack");
                    }
                    break;
                case "swap":
                    if (stack.size() >= 2) {
                        int temp = stack.pop();
                        stack.pop();
                        stack.push(temp);
                    } else {
                        System.err.println("Error: swap requires at least two elements in stack");
                    }
                    break;
                case "print":
                    if (!stack.isEmpty()) {
                        System.out.println(stack.peek());
                    } else {
                        System.err.println("Error: print requires at least one element in stack");
                    }
                    break;
                default:
                    System.err.println("Unknown command: " + parts[0]);
                    break;
            }
        }
    }
}
