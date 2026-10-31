package benchmark.p04_bst;

import java.io.*;

public class P04Bst {
    static class Node {
        int value;
        Node left = null;
        Node right = null;

        Node(int value) { this.value = value; }
    }

    static Node insert(Node root, int value) {
        if (root == null) return new Node(value);
        Node current = root;
        while (true) {
            if (value < current.value) {
                if (current.left == null) { 
                    current.left = new Node(value);
                    return root; 
                }
                current = current.left;
            } else {
                if (current.right == null) { 
                    current.right = new Node(value);
                    return root; 
                }
                current = current.right;
            }
        }
    }

    static void inorder(Node node, StringBuilder out) {
        if (node == null) return;

        inorder(node.left, out);

        if (out.length() > 0) out.append(' ');
        out.append(node.value);

        inorder(node.right, out);
    }

    static void preorder(Node node, StringBuilder out) {
        if (node == null) return;

        if (out.length() > 0) out.append(' ');
        out.append(node.value);

        preorder(node.left, out);
        preorder(node.right, out);
    }

    static int height(Node node) {
        return node == null ? 0 : 1 + Math.max(height(node.left), height(node.right));
    }

    public static void main(String[] args) throws Exception {
        String line = new BufferedReader(new InputStreamReader(System.in)).readLine();
        if (line == null) line = "";

        Node root = null;
        for (String token : line.split("\\s+")) {
            if (!token.isEmpty()) root = insert(root, Integer.parseInt(token));
        }

        StringBuilder in = new StringBuilder();
        StringBuilder pre = new StringBuilder();
        inorder(root, in); 
        preorder(root, pre);

        System.out.println(in);
        System.out.println(pre);
        System.out.println(height(root));
    }
}
