 
import java.util.*;
 
public class Calc {
 
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter your equation:");
        String input = scanner.nextLine().trim();
        try {
            System.out.println(calc(input));
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }
 
    private static double calc(String input) throws Exception {
        Stack<Double> numbers = new Stack<>();
        Stack<String> ops = new Stack<>();
        int i = 0;
        while (i < input.length()) {
            char c = input.charAt(i);
            if (c == ' ') {
                i++;
                continue;
            }
            if (Character.isDigit(c)) {
                StringBuilder sb = new StringBuilder();
                while (i < input.length() && Character.isDigit(input.charAt(i))) {
                    sb.append(input.charAt(i));
                    i++;
                }
                numbers.push(Double.parseDouble(sb.toString()));
                i--;
            } else if (c == '(') {
                ops.push("(");
            } else if (c == ')') {
                while (!ops.isEmpty() && !ops.peek().equals("(")) {
                    numbers.push(applyOp(numbers.pop(), numbers.pop(), ops.pop()));
                }
                ops.pop();
            } else if (c == '+' || c == '-' || c == '*' || c == '/') {
                while (!ops.isEmpty() && hasPrecedence(c, ops.peek())) {
                    numbers.push(applyOp(numbers.pop(), numbers.pop(), ops.pop()));
                }
                ops.push("" + c);
            }
            i++;
        }
        while (!ops.isEmpty()) {
            numbers.push(applyOp(numbers.pop(), numbers.pop(), ops.pop()));
        }
        return numbers.pop();
    }
 
    private static boolean hasPrecedence(char op1, String op2) {
        if ((op1 == '*' || op1 == '/') && (op2.equals("+") || op2.equals("-"))) {
            return false;
        }
        return true;
    }
 
    private static double applyOp(double b, double a, String op) throws Exception {
        switch (op) {
            case "+":
                return a + b;
            case "-":
                return a - b;
            case "*":
                return a * b;
            case "/":
                if (b == 0)
                    throw new Exception("Cannot divide by zero");
                return a / b;
        }
        return 0;
    }
}
 
