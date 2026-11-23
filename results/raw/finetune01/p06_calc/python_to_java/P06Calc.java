import java.util.*;
 
public class Calc {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter your equation:");
        String input = scanner.nextLine();
        System.out.println(calc(input));
    }
 
    private static double calc(String input) {
        Stack<Double> numbers = new Stack<>();
        Stack<String> operators = new Stack<>();
        List<String> tokens = tokenize(input);
        for (String token : tokens) {
            switch (token) {
                case "(":
                    operators.push(token);
                    break;
                case ")":
                    while (!operators.isEmpty() && !operators.peek().equals("(")) {
                        numbers.push(applyOp(numbers.pop(), numbers.pop(), operators.pop()));
                    }
                    operators.pop(); // pop "("
                    break;
                case "+" :
                case "-" :
                case "*" :
                case "/" :
                    while (!operators.isEmpty() && precedence(operators.peek()) >= precedence(token)) {
                        numbers.push(applyOp(numbers.pop(), numbers.pop(), operators.pop()));
                    }
                    operators.push(token);
                    break;
                default:
                    numbers.push(Double.parseDouble(token));
            }
        }
        while (!operators.isEmpty()) {
            numbers.push(applyOp(numbers.pop(), numbers.pop(), operators.pop()));
        }
        return numbers.pop();
    }
 
    private static List<String> tokenize(String input) {
        List<String> tokens = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        for (char c : input.toCharArray()) {
            if (Character.isDigit(c) || c == '.') {
                sb.append(c);
            } else if (c != ' ') {
                tokens.add(sb.toString());
                sb.setLength(0);
                tokens.add(Character.toString(c));
            }
        }
        tokens.add(sb.toString());
        return tokens;
    }
 
    private static int precedence(String operator) {
        switch (operator) {
            case "+":
            case "-":
                return 1;
            case "*":
            case "/":
                return 2;
        }
        return 0;
    }
 
    private static double applyOp(double b, double a, String operator) {
        switch (operator) {
            case "+":
                return a + b;
            case "-":
                return a - b;
            case "*":
                return a * b;
            case "/":
                if (b == 0) throw new IllegalArgumentException("Cannot divide by zero");
                return a / b;
        }
        return 0;
    }
}
