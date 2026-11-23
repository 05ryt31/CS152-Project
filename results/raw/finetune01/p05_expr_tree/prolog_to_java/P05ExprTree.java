import java.util.*;
 
class Node {
    String value;
    Node left;
    Node right;
 
    public Node(String v) {
        this.value = v;
    }
}
 
public class ExpressionTree {
    private static final Map<String, Integer> precedence = new HashMap<>();
 
    static {
        precedence.put("+", 1);
        precedence.put("-", 1);
        precedence.put("*", 2);
        precedence.put("/", 2);
        precedence.put("^", 3);
    }
 
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter expression:");
        String expr = scanner.nextLine();
        Node root = parseExpression(expr);
        printTree(root, "");
        System.out.println("\n" + evaluate(root));
    }
 
    private static Node parseExpression(String expr) {
        return parseExpression(expr, 0, expr.length() - 1);
    }
 
    private static Node parseExpression(String expr, int start, int end) {
        if (start > end)
            return null;
        if (start == end)
            return new Node(expr.substring(start, end + 1));
 
        int maxPrecedence = 0;
        int pos = start;
        for (; pos <= end; ++pos) {
            char c = expr.charAt(pos);
            if (c == ' ')
                continue;
            if (isOperator(c)) {
                int p = precedence.get("" + c);
                if (p > maxPrecedence) {
                    maxPrecedence = p;
                    pos++;
                }
            } else {
                break;
            }
        }
 
        Node node = new Node(expr.substring(pos - 1, pos));
        node.left = parseExpression(expr, start, pos - 2);
        node.right = parseExpression(expr, pos, end);
        return node;
    }
 
    private static boolean isOperator(char c) {
        return "+-*/^".indexOf(c) != -1;
    }
 
    private static void printTree(Node n, String prefix) {
        if (n == null)
            return;
        printTree(n.right, prefix + "    ");
        System.out.println(prefix + n.value);
        printTree(n.left, prefix + "    ");
    }
 
    private static long evaluate(Node n) {
        if (n == null)
            return 0;
        if (n.left == null && n.right == null)
            return Long.parseLong(n.value);
        long l = evaluate(n.left);
        long r = evaluate(n.right);
        switch (n.value) {
            case "+":
                return l + r;
            case "-":
                return l - r;
            case "*":
                return l * r;
            case "/":
                return l / r;
            case "^":
                return (long) Math.pow(l, r);
        }
        throw new RuntimeException("Unknown operator");
    }
}
