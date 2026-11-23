import java.util.*;
 
public class StackVM {
 
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter number of instructions:");
        int numInstructions = Integer.parseInt(scanner.nextLine());
        List<String> instructions = new ArrayList<>();
        for (int i = 0; i < numInstructions; i++) {
            instructions.add(scanner.nextLine());
        }
        Stack<Integer> stack = new Stack<>();
        for (String instruction : instructions) {
            if (instruction.equals("pop")) {
                if (!stack.isEmpty()) {
                    stack.pop();
                } else {
                    System.err.println("Error");
                }
            } else if (instruction.equals("add")) {
                if (stack.size() >= 2) {
                    stack.push(stack.pop() + stack.pop());
                } else {
                    System.err.println("Error");
                }
            } else if (instruction.equals("mul")) {
                if (stack.size() >= 2) {
                    stack.push(stack.pop() * stack.pop());
                } else {
                    System.err.println("Error");
                }
            } else if (instruction.equals("dup")) {
                if (!stack.isEmpty()) {
                    stack.push(stack.peek());
                } else {
                    System.err.println("Error");
                }
            } else if (instruction.equals("swap")) {
                if (stack.size() >= 2) {
                    int temp = stack.pop();
                    stack.pop();
                    stack.push(temp);
                } else {
                    System.err.println("Error");
                }
            } else if (instruction.equals("print")) {
                if (!stack.isEmpty()) {
                    System.out.println(stack.peek());
                } else {
                    System.err.println("Error");
                }
            } else if (instruction.startsWith("push ")) {
                try {
                    stack.push(Integer.parseInt(instruction.substring(5)));
                } catch (NumberFormatException e) {
                    System.err.println("Error");
                }
            } else {
                System.err.println("Error");
            }
        }
    }
}
