import java.util.*;
 
public class Calc {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.print("Enter expression: ");
            String expr = scanner.nextLine();
            if (expr.equals("")) break;
            try {
                System.out.println(calc(expr));
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }
        }
    }
 
    private static int calc(String s) throws Exception {
        Stack<Integer> nums = new Stack<>();
        Stack<Character> ops = new Stack<>();
        for (int i = 0; i < s.length(); i++) {
            char ch = s.charAt(i);
            switch (ch) {
                case '+':
                    while (!ops.isEmpty() && precedence(ops.peek()) >= 1)
                        applyOp(nums, ops);
                    ops.push(ch);
                    break;
                case '-':
                    while (!ops.isEmpty() && precedence(ops.peek()) >= 1)
                        applyOp(nums, ops);
                    ops.push(ch);
                    break;
                case '*':
                    while (!ops.isEmpty() && precedence(ops.peek()) >= 2)
                        applyOp(nums, ops);
                    ops.push(ch);
                    break;
                case '/':
                    while (!ops.isEmpty() && precedence(ops.peek()) >= 2)
                        applyOp(nums, ops);
                    ops.push(ch);
                    break;
                case '(':
                    ops.push(ch);
                    break;
                case ')':
                    while (!ops.isEmpty() && ops.peek() != '(')
                        applyOp(nums, ops);
                    if (ops.isEmpty())
                        throw new Exception("Mismatched parentheses");
                    ops.pop();
                    break;
                default:
                    StringBuilder sb = new StringBuilder();
                    while (i < s.length() && Character.isDigit(s.charAt(i)))
                        sb.append(s.charAt(i++));
                    nums.push(Integer.parseInt(sb.toString()));
                    i--;
                    break;
            }
        }
        while (!ops.isEmpty())
            applyOp(nums, ops);
        return nums.pop();
    }
 
    private static void applyOp(Stack<Integer> nums, Stack<Character> ops) throws Exception {
        int b = nums.pop(), a = nums.pop();
        char op = ops.pop();
        switch (op) {
            case '+': nums.push(a + b); break;
            case '-': nums.push(a - b); break;
            case '*': nums.push(a * b); break;
            case '/':
                if (b == 0)
                    throw new Exception("Division by zero");
                nums.push(a / b);
                break;
        }
    }
 
    private static int precedence(char op) {
        switch (op) {
            case '+':
            case '-': return 1;
            case '*':
            case '/': return 2;
        }
        return 0;
    }
}
