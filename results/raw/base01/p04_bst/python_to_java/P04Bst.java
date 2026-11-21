package results.raw.base01.p04_bst.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class P04Bst {
    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String[] tokens = reader.readLine().split();
        Node root = null;
        for (String token : tokens) {
            root = insert(root, Integer.parseInt(token));
        }
        List<Integer> inValues = new ArrayList<>();
        inorder(root, inValues);
        List<Integer> preValues = new ArrayList<>();
        preorder(root, preValues);
        System.out.println(String.join(" ", inValues.stream().map(String::valueOf).toArray(String[]::new)));
        System.out.println(String.join(" ", preValues.stream().map(String::valueOf).toArray(String[]::new)));
        System.out.println(height(root));
    }

    private static Node insert(Node root, int value) {
        Node node = new Node(value);
        if (root == null) {
            return node;
        }
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

    private static void inorder(Node node, List<Integer> out) {
        if (node != null) {
            inorder(node.left, out);
            out.add(node.value);
            inorder(node.right, out);
        }
    }

    private static void preorder(Node node, List<Integer> out) {
        if (node != null) {
            out.add(node.value);
            preorder(node.left, out);
            preorder(node.right, out);
        }
    }

    private static int height(Node node) {
        if (node == null) {
            return 0;
        }
        return 1 + Math.max(height(node.left), height(node.right));
    }

    private static class Node {
        int value;
        Node left;
        Node right;

        Node(int value) {
            this.value = value;
            this.left = null;
            this.right = null;
        }
    }
}
