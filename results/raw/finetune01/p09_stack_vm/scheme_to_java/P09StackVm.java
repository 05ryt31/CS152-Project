import java.util.*;
 
public class StackVM {
 
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter number of instructions:");
        int numInstructions = Integer.parseInt(scanner.nextLine());
        String[] instructions = new String[numInstructions];
        for (int i = 0; i < numInstructions; i++) {
            instructions[i] = scanner.nextLine();
        }
        Stack<Integer> stack = new Stack<>();
        for (String instruction : instructions) {
            String[] tokens = instruction.split("\\s+");
            switch (tokens[0]) {
                case "push":
                    stack.push(Integer.parseInt(tokens[1]));
                    break;
                case "pop":
                    if (!stack.isEmpty()) {
                        stack.pop();
                    } else {
                        System.err.println("Error");
                    }
                    break;
                case "add":
                    if (stack.size() >= 2) {
                        stack.push(stack.pop() + stack.pop());
                    } else {
                        System.err.println("Error");
                    }
                    break;
                case "mul":
                    if (stack.size() >= 2) {
                        stack.push(stack.pop() * stack.pop());
                    } else {
                        System.err.println("Error");
                    }
                    break;
                case "dup":
                    if (!stack.isEmpty()) {
                        stack.push(stack.peek());
                    } else {
                        System.err.println("Error");
                    }
                    break;
                case "swap":
                    if (stack.size() >= 2) {
                        int temp = stack.pop();
                        stack.pop();
                        stack.push(temp);
                    } else {
                        System.err.println("Error");
                    }
                    break;
                default:
                    if (!stack.isEmpty()) {
                        System.out.println(stack.pop());
                    } else {
                        System.err.println("Error");
                    }
                    break;
            }
        }
    }
}
