package results.raw.base01.p05_expr_tree.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Stack;

public class P05ExprTree {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String[] tokens = reader.readLine().split(" ");
        Node tree = build(tokens);
        System.out.println(render(tree));
    }

    private static Node build(String[] tokens) {
        Stack<Node> stack = new Stack<>();
        for (String token : tokens) {
            if (token.equals("+") || token.equals("-") || token.equals("*")) {
                Node right = stack.pop();
                Node left = stack.pop();
                stack.push(new Node(token, left, right));
            } else {
                stack.push(new Node(token));
            }
        }
        return stack.pop();
    }

    private static String render(Node node) {
        if (node.left == null && node.right == null) {
            return node.token;
        }
        return "(" + render(node.left) + " " + node.token + " " + render(node.right) + ")";
    }
}

class Node {
    String token;
    Node left;
    Node right;

    Node(String token, Node left, Node right) {
        this.token = token;
        this.left = left;
        this.right = right;
    }

    Node(String token) {
        this.token = token;
        this.left = null;
        this.right = null;
    }
}
