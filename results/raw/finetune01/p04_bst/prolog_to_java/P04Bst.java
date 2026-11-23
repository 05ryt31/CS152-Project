import java.util.*;
 
class Node {
    int value;
    Node left = null;
    Node right = null;
 
    public Node(int v) {value = v;}
}
 
public class BST {
    private Node root = null;
 
    public void add(int val) {
        if (root == null)
            root = new Node(val);
        else
            add(root, val);
    }
 
    private void add(Node n, int val) {
        if (val <= n.value) {
            if (n.left != null)
                add(n.left, val);
            else
                n.left = new Node(val);
        } else {
            if (n.right != null)
                add(n.right, val);
            else
                n.right = new Node(val);
        }
    }
 
    public void inOrder() {
        inOrder(root);
    }
 
    private void inOrder(Node n) {
        if (n != null) {
            inOrder(n.left);
            System.out.print(n.value + " ");
            inOrder(n.right);
        }
    }
 
    public void preOrder() {
        preOrder(root);
    }
 
    private void preOrder(Node n) {
        if (n != null) {
            System.out.print(n.value + " ");
            preOrder(n.left);
            preOrder(n.right);
        }
    }
 
    public int height() {
        return height(root);
    }
 
    private int height(Node n) {
        if (n == null)
            return 0;
        else {
            int lHeight = height(n.left);
            int rHeight = height(n.right);
 
            if (lHeight > rHeight)
                return (lHeight + 1);
            else
                return (rHeight + 1);
        }
    }
 
    public static void main(String[] args) {
        BST tree = new BST();
        Scanner s = new Scanner(System.in);
        while (s.hasNextInt())
            tree.add(s.nextInt());
        System.out.println("In order:");
        tree.inOrder();
        System.out.println("\n\nPre order:");
        tree.preOrder();
        System.out.println("\n\nTree height: " + tree.height());
    }
}
