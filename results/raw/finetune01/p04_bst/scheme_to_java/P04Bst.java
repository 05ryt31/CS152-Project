import java.util.*;
 
class Node {
    int data;
    Node left = null;
    Node right = null;
 
    public Node(int data) {
        this.data = data;
    }
}
 
public class Tree {
    private Node root;
 
    public Tree(int[] arr) {
        Arrays.sort(arr);
        root = buildTree(arr, 0, arr.length - 1);
    }
 
    private Node buildTree(int[] arr, int start, int end) {
        if (start > end) return null;
 
        int mid = (start + end) / 2;
        Node node = new Node(arr[mid]);
        node.left = buildTree(arr, start, mid - 1);
        node.right = buildTree(arr, mid + 1, end);
 
        return node;
    }
 
    public void printInOrder() {
        inOrder(root);
    }
 
    private void inOrder(Node node) {
        if (node == null) return;
 
        inOrder(node.left);
        System.out.print(node.data + " ");
        inOrder(node.right);
    }
 
    public void printPreOrder() {
        preOrder(root);
    }
 
    private void preOrder(Node node) {
        if (node == null) return;
 
        System.out.print(node.data + " ");
        preOrder(node.left);
        preOrder(node.right);
    }
 
    public int height() {
        return getHeight(root);
    }
 
    private int getHeight(Node node) {
        if (node == null) return 0;
 
        return Math.max(getHeight(node.left), getHeight(node.right)) + 1;
    }
 
    public static void main(String[] args) {
        int[] arr = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5};
        Tree t = new Tree(arr);
 
        System.out.println("In Order:");
        t.printInOrder();
 
        System.out.println("\n\nPre Order:");
        t.printPreOrder();
 
        System.out.println("\n\nHeight: " + t.height());
    }
}
