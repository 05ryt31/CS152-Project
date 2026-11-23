import java.util.*;
 
public class StackVM {
 
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        List<String> commands = new ArrayList<>();
        while (scanner.hasNextLine()) {
            commands.add(scanner.nextLine());
        }
        Stack<Integer> stack = new Stack<>();
        for (String command : commands) {
            String[] splitCommand = command.split(" ");
            switch (splitCommand[0]) {
                case "push":
                    stack.push(Integer.parseInt(splitCommand[1]));
                    break;
                case "pop":
                    if (stack.isEmpty())
                        System.out.println("error");
                    else
                        stack.pop();
                    break;
                case "add":
                    if (stack.size() < 2)
                        System.out.println("error");
                    else {
                        int a = stack.pop();
                        int b = stack.pop();
                        stack.push(a + b);
                    }
                    break;
                case "mul":
                    if (stack.size() < 2)
                        System.out.println("error");
                    else {
                        int a = stack.pop();
                        int b = stack.pop();
                        stack.push(a * b);
                    }
                    break;
                case "dup":
                    if (stack.isEmpty())
                        System.out.println("error");
                    else
                        stack.push(stack.peek());
                    break;
                case "swap":
                    if (stack.size() < 2)
                        System.out.println("error");
                    else {
                        int a = stack.pop();
                        int b = stack.pop();
                        stack.push(a);
                        stack.push(b);
                    }
                    break;
                default:
                    if (stack.isEmpty())
                        System.out.println("error");
                    else
                        System.out.println(stack.peek());
                    break;
            }
        }
    }
}
