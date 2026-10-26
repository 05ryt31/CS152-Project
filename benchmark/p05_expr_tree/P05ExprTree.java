package benchmark.p05_expr_tree;

import java.io.*;
import java.util.*;

public class P05ExprTree {
    static class Node {
        String token;
        Node left = null;
        Node right = null;

        Node(String token) { this.token = token; }
        Node(String token, Node left, Node right) {
            this.token = token;
            this.left = left;
            this.right = right;
        }
    }

    static String render(Node node) {
        if (node.left == null && node.right == null) return node.token;
        return "(" + render(node.left) + " " + node.token + " " + render(node.right) + ")";
    }

    public static void main(String[] args) throws Exception {
        String[] tokens = new BufferedReader(new InputStreamReader(System.in)).readLine().split("\\s+");
        Deque<Node> stack = new ArrayDeque<>();

        for (String token : tokens) {
            if ("+".equals(token) || "-".equals(token) || "*".equals(token)) {
                Node right = stack.pop();
                Node left = stack.pop();
                Node parent = new Node(token, left, right);
                stack.push(parent);
            } else  {
                stack.push(new Node(token));
            }
        }

        System.out.println(render(stack.pop()));
    }
}
