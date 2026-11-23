import java.util.*;
 
public class StackVM {
 
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter number of commands:");
        int numCommands = Integer.parseInt(scanner.nextLine());
        String[] commands = new String[numCommands];
        for (int i = 0; i < numCommands; i++) {
            commands[i] = scanner.nextLine();
        }
        Stack<Integer> stack = new Stack<>();
        for (String command : commands) {
            String[] splitCommand = command.split("\\s+");
            switch (splitCommand[0]) {
                case "push":
                    stack.push(Integer.parseInt(splitCommand[1]));
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
                        stack.add(stack.pop() + stack.pop());
                    } else {
                        System.err.println("Error");
                    }
                    break;
                case "mul":
                    if (stack.size() >= 2) {
                        stack.add(stack.pop() * stack.pop());
                    } else {
                        System.err.println("Error");
                    }
                    break;
                case "dup":
                    if (!stack.isEmpty()) {
                        stack.add(stack.peek());
                    } else {
                        System.err.println("Error");
                    }
                    break;
                case "swap":
                    if (stack.size() >= 2) {
                        int temp = stack.pop();
                        stack.set(stack.size() - 2, stack.pop());
                        stack.add(temp);
                    } else {
                        System.err.println("Error");
                    }
                    break;
                case "print":
                    if (!stack.isEmpty()) {
                        System.out.println(stack.peek());
                    } else {
                        System.err.println("Error");
                    }
                    break;
                default:
                    System.err.println("Unknown command: " + splitCommand[0]);
                    break;
            }
        }
    }
}
