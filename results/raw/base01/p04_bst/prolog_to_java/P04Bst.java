package results.raw.base01.p04_bst.prolog_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class P04Bst {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new BufferedReader(new InputStreamReader(System.in)))) {
            String line = scanner.nextLine();
            List<Integer> ns = nums(line);
            Node tree = empty;
            for (int n : ns) {
                tree = insert(n, tree);
            }
            List<Integer> inOrder = new ArrayList<>();
            inorder(tree, inOrder);
            List<Integer> preOrder = new ArrayList<>();
            preorder(tree, preOrder);
            printNums(inOrder);
            printNums(preOrder);
            int height = height(tree);
            System.out.println(height);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static List<Integer> nums(String line) {
        if (line == null || line.isEmpty()) {
            return List.of();
        }
        String[] parts = line.split(" ");
        List<Integer> ns = new ArrayList<>();
        for (String part : parts) {
            ns.add(Integer.parseInt(part));
        }
        return ns;
    }

    private static Node insert(int x, Node tree) {
        if (tree == null) {
            return new Node(x, null, null);
        } else if (x < tree.value) {
            tree.left = insert(x, tree.left);
        } else {
            tree.right = insert(x, tree.right);
        }
        return tree;
    }

    private static void inorder(Node tree, List<Integer> list) {
        if (tree != null) {
            inorder(tree.left, list);
            list.add(tree.value);
            inorder(tree.right, list);
        }
    }

    private static void preorder(Node tree, List<Integer> list) {
        if (tree != null) {
            list.add(tree.value);
            preorder(tree.left, list);
            preorder(tree.right, list);
        }
    }

    private static int height(Node tree) {
        if (tree == null) {
            return 0;
        } else {
            int leftHeight = height(tree.left);
            int rightHeight = height(tree.right);
            return 1 + Math.max(leftHeight, rightHeight);
        }
    }

    private static void printNums(List<Integer> ns) {
        if (!ns.isEmpty()) {
            System.out.print(ns.stream().mapToInt(i -> i).summaryStatistics().getMin());
            for (int i = 1; i < ns.size(); i++) {
                System.out.print(" " + ns.get(i));
            }
            System.out.println();
        }
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

    private static final Node empty = null;
}
