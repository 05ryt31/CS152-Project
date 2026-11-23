import java.util.*;
 
class Node {
    public String value;
    public Node left;
    public Node right;
 
    public Node(String v, Node l, Node r) {
        this.value = v;
        this.left = l;
        this.right = r;
    }
}
 
public class ExpressionTree {
    private static final Set<String> operators = new HashSet<>(Arrays.asList("+", "-", "*", "/"));
 
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter expression:");
        String expr = scanner.nextLine();
        Node tree = buildTree(expr.split("\\s+"));
        printTree(tree);
    }
 
    private static Node buildTree(String[] tokens) {
        Stack<Node> nodes = new Stack<>();
        Stack<String> ops = new Stack<>();
        for (String token : tokens) {
            if (!operators.contains(token)) {
                nodes.push(new Node(token, null, null));
            } else {
                while (!ops.isEmpty() && precedence(ops.peek()) >= precedence(token)) {
                    Node node = new Node(ops.pop(), nodes.pop(), nodes.pop());
                    nodes.push(node);
                }
                ops.push(token);
            }
        }
        while (!ops.isEmpty()) {
            Node node = new Node(ops.pop(), nodes.pop(), nodes.pop());
            nodes.push(node);
        }
        return nodes.pop();
    }
 
    private static int precedence(String op) {
        switch (op) {
            case "+":
            case "-":
                return 1;
            case "*":
            case "/":
                return 2;
            default:
                throw new IllegalArgumentException("Unknown operator: " + op);
        }
    }
 
    private static void printTree(Node node) {
        if (node == null)
            return;
        if (node.left != null || node.right != null) {
            System.out.print("(");
            printTree(node.left);
            System.out.print(" " + node.value + " ");
            printTree(node.right);
            System.out.print(")");
        } else {
            System.out.print(node.value);
        }
    }
}
