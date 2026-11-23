import java.util.*;
 
class Node {
    String value;
    List<Node> children = new ArrayList<>();
 
    public Node(String value) {
        this.value = value;
    }
}
 
public class ExpressionTree {
    private static final Set<String> operators = new HashSet<>(Arrays.asList("+", "-", "*", "/"));
 
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println(build(scanner.nextLine()));
    }
 
    private static Node build(String expression) {
        Stack<Node> nodes = new Stack<>();
        Stack<Character> ops = new Stack<>();
        int i = 0;
        while (i < expression.length()) {
            char c = expression.charAt(i++);
            if (Character.isWhitespace(c))
                continue;
            if (Character.isDigit(c)) {
                StringBuilder sb = new StringBuilder();
                do {
                    sb.append(c);
                    c = expression.charAt(i++);
                } while (Character.isDigit(c));
                nodes.push(new Node(sb.toString()));
                i--;
            } else if (operators.contains("" + c)) {
                while (!ops.isEmpty() && precedence(ops.peek()) >= precedence(c)) {
                    Node node = nodes.pop();
                    Node parent = nodes.pop();
                    parent.children.add(node);
                    nodes.push(parent);
                }
                ops.push(c);
            } else if (c == '(') {
                nodes.push(build(expression.substring(i)));
                i += nodes.peek().value.length();
            } else if (c == ')') {
                return nodes.pop();
            }
        }
        while (!ops.isEmpty()) {
            Node node = nodes.pop();
            Node parent = nodes.pop();
            parent.children.add(node);
            nodes.push(parent);
        }
        return nodes.pop();
    }
 
    private static int precedence(char op) {
        switch (op) {
            case '+':
            case '-':
                return 1;
            case '*':
            case '/':
                return 2;
            default:
                throw new IllegalArgumentException("Unknown operator");
        }
    }
 
    private static String render(Node root) {
        if (root.children.isEmpty())
            return root.value;
        StringBuilder sb = new StringBuilder("(");
        for (Node child : root.children)
            sb.append(render(child)).append(' ');
        sb.setLength(sb.length() - 1);
        sb.append(')').append(root.value);
        return sb.toString();
    }
 
    public static String render(Node root) {
        return render(root).replaceAll("\\s+", "");
    }
}
