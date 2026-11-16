package results.raw.base01.p04_bst.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class P04Bst {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String line = reader.readLine();
        List<Integer> values = new ArrayList<>();
        if (line != null && !line.trim().isEmpty()) {
            for (String s : line.split("\\s+")) {
                values.add(Integer.parseInt(s));
            }
        }

        Node root = null;
        for (int value : values) {
            root = insert(root, value);
        }

        List<Integer> inOrder = new ArrayList<>();
        inorder(root, inOrder);

        List<Integer> preOrder = new ArrayList<>();
        preorder(root, preOrder);

        System.out.println(String.join(" ", inOrder.stream().map(String::valueOf).toArray(String[]::new)));
        System.out.println(String.join(" ", preOrder.stream().map(String::valueOf).toArray(String[]::new)));
        System.out.println(height(root));
    }

    static class Node {
        int value;
        Node left;
        Node right;

        Node(int value, Node left, Node right) {
            this.value = value;
            this.left = left;
            this.right = right;
        }
    }

    static Node insert(Node root, int value) {
        Node node = new Node(value);
        if (root == null) return node;

        Node current = root;
        while (true) {
            if (value < current.value) {
                if (current.left == null) {
                    current.left = node;
                    return root;
                }
                current = current.left;
            } else {
                if (current.right == null) {
                    current.right = node;
                    return root;
                }
                current = current.right;
            }
        }
    }

    static void inorder(Node root, List<Integer> out) {
        if (root != null) {
            inorder(root.left, out);
            out.add(root.value);
            inorder(root.right, out);
        }
    }

    static void preorder(Node root, List<Integer> out) {
        if (root != null) {
            out.add(root.value);
            preorder(root.left, out);
            preorder(root.right, out);
        }
    }

    static int height(Node root) {
        return root != null ? 1 + Math.max(height(root.left), height(root.right)) : 0;
    }
}
