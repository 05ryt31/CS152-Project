package results.raw.base01.p05_expr_tree.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Stack;

public class P05ExprTree {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            String input = reader.readLine();
            if (input == null || input.trim().isEmpty()) {
                System.exit(0);
            }

            String[] tokens = input.split("\\s+");
            Stack<Node> stack = new Stack<>();

            for (String token : tokens) {
                if ("+-*".contains(token)) {
                    Node right = stack.pop();
                    Node left = stack.pop();
                    stack.push(new Node(token, left, right));
                } else {
                    stack.push(new Node(token));
                }
            }

            System.out.println(render(stack.peek()));
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }
    }

    private static String render(Node node) {
        if (node.left == null && node.right == null) {
            return node.token;
        }
        return "(" + render(node.left) + " " + node.token + " " + render(node.right) + ")";
    }

    private static class Node {
        String token;
        Node left;
        Node right;

        Node(String token) {
            this.token = token;
        }

        Node(String token, Node left, Node right) {
            this.token = token;
            this.left = left;
            this.right = right;
        }
    }
}
