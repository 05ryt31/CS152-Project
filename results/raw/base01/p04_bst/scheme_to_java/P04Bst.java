package results.raw.base01.p04_bst.scheme_to_java;

import java.util.*;

public class P04Bst {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        List<Integer> numbers = numbers(line);
        Node tree = buildTree(numbers);
        printList(inorder(tree));
        printList(preorder(tree));
        System.out.println(height(tree));
    }

    private static Node insert(Node tree, int value) {
        if (tree == null) {
            return new Node(value, null, null);
        }
        if (value < tree.value) {
            tree.left = insert(tree.left, value);
        } else {
            tree.right = insert(tree.right, value);
        }
        return tree;
    }

    private static List<Integer> inorder(Node tree) {
        List<Integer> result = new ArrayList<>();
        inorderHelper(tree, result);
        return result;
    }

    private static void inorderHelper(Node node, List<Integer> result) {
        if (node != null) {
            inorderHelper(node.left, result);
            result.add(node.value);
            inorderHelper(node.right, result);
        }
    }

    private static List<Integer> preorder(Node tree) {
        List<Integer> result = new ArrayList<>();
        preorderHelper(tree, result);
        return result;
    }

    private static void preorderHelper(Node node, List<Integer> result) {
        if (node != null) {
            result.add(node.value);
            preorderHelper(node.left, result);
            preorderHelper(node.right, result);
        }
    }

    private static int height(Node tree) {
        if (tree == null) {
            return 0;
        }
        return Math.max(height(tree.left), height(tree.right)) + 1;
    }

    private static void printList(List<Integer> values) {
        if (!values.isEmpty()) {
            System.out.print(values.get(0));
            for (int i = 1; i < values.size(); i++) {
                System.out.print(" " + values.get(i));
            }
            System.out.println();
        }
    }

    private static List<Integer> numbers(String line) {
        if (line.isEmpty()) {
            return Collections.emptyList();
        }
        String[] parts = line.split("\\s+");
        List<Integer> result = new ArrayList<>();
        for (String part : parts) {
            result.add(Integer.parseInt(part));
        }
        return result;
    }

    private static String safeReadLine(Scanner scanner) {
        if (scanner.hasNextLine()) {
            return scanner.nextLine();
        }
        return "";
    }

    private static Node buildTree(List<Integer> values) {
        Node tree = null;
        for (int value : values) {
            tree = insert(tree, value);
        }
        return tree;
    }

    private static class Node {
        int value;
        Node left;
        Node right;

        Node(int value, Node left, Node right) {
            this.value = value;
            this.left = left;
            this.right = right;
        }
    }
}
