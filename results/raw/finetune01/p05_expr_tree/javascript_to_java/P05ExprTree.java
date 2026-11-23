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
    private static final Set<String> operators = new HashSet<>(Arrays.asList("+", "-", "*", "/"));
 
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter expression:");
        String expr = scanner.nextLine();
        Node root = parse(expr.split("\\s+"), 0)[0];
        print(root, "");
    }
 
    private static Node[] parse(String[] tokens, int index) {
        Node root = new Node(tokens[index]);
        if (operators.contains(tokens[index])) {
            Node[] left = parse(tokens, index + 1);
            Node[] right = parse(tokens, left[1] + 1);
            root.left = left[0];
            root.right = right[0];
            return new Node[]{root, right[1]};
        } else {
            return new Node[]{root, index};
        }
    }
 
    private static void print(Node node, String indent) {
        if (node != null) {
            print(node.right, indent + "   ");
            System.out.println(indent + node.value);
            print(node.left, indent + "   ");
        }
    }
}
