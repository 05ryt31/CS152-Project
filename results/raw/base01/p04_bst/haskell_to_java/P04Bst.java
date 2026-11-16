package results.raw.base01.p04_bst.haskell_to_java;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class P04Bst {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            List<Integer> values = new ArrayList<>();
            String line = reader.readLine();
            while (line != null && !line.isEmpty()) {
                for (String value : line.split("\\s+")) {
                    values.add(Integer.parseInt(value));
                }
                line = reader.readLine();
            }

            TreeNode root = null;
            for (int value : values) {
                root = insert(root, value);
            }

            System.out.println(showLine(inorder(root)));
            System.out.println(showLine(preorder(root)));
            System.out.println(height(root));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static TreeNode insert(TreeNode node, int key) {
        if (node == null) {
            return new TreeNode(key);
        }
        if (key < node.value) {
            node.left = insert(node.left, key);
        } else {
            node.right = insert(node.right, key);
        }
        return node;
    }

    private static List<Integer> inorder(TreeNode node) {
        List<Integer> result = new ArrayList<>();
        inorderHelper(node, result);
        return result;
    }

    private static void inorderHelper(TreeNode node, List<Integer> result) {
        if (node != null) {
            inorderHelper(node.left, result);
            result.add(node.value);
            inorderHelper(node.right, result);
        }
    }

    private static List<Integer> preorder(TreeNode node) {
        List<Integer> result = new ArrayList<>();
        preorderHelper(node, result);
        return result;
    }

    private static void preorderHelper(TreeNode node, List<Integer> result) {
        if (node != null) {
            result.add(node.value);
            preorderHelper(node.left, result);
            preorderHelper(node.right, result);
        }
    }

    private static int height(TreeNode node) {
        if (node == null) {
            return 0;
        }
        return 1 + Math.max(height(node.left), height(node.right));
    }

    private static String showLine(List<Integer> xs) {
        return xs.stream().map(String::valueOf).collect(Collectors.joining(" "));
    }

    private static class TreeNode {
        int value;
        TreeNode left;
        TreeNode right;

        TreeNode(int value) {
            this.value = value;
            this.left = null;
            this.right = null;
        }
    }
}
