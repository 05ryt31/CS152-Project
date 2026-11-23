import java.util.*;
 
class BST {
    private Node root;
 
    public BST() {
        this.root = null;
    }
 
    public boolean isEmpty() {
        return this.root == null;
    }
 
    public int size() {
        return this.size(this.root);
    }
 
    private int size(Node node) {
        if (node == null)
            return 0;
        else
            return 1 + this.size(node.left) + this.size(node.right);
    }
 
    public void insert(int key) {
        this.root = this.insert(this.root, key);
    }
 
    private Node insert(Node node, int key) {
        if (node == null)
            return new Node(key);
        else if (key < node.key)
            node.left = this.insert(node.left, key);
        else if (key > node.key)
            node.right = this.insert(node.right, key);
        return node;
    }
 
    public void inOrderTraversal() {
        this.inOrderTraversal(this.root);
    }
 
    private void inOrderTraversal(Node node) {
        if (node != null) {
            this.inOrderTraversal(node.left);
            System.out.print(node.key + " ");
            this.inOrderTraversal(node.right);
        }
    }
 
    public void preOrderTraversal() {
        this.preOrderTraversal(this.root);
    }
 
    private void preOrderTraversal(Node node) {
        if (node != null) {
            System.out.print(node.key + " ");
            this.preOrderTraversal(node.left);
            this.preOrderTraversal(node.right);
        }
    }
 
    public int height() {
        return this.height(this.root);
    }
 
    private int height(Node node) {
        if (node == null)
            return -1;
        else
            return 1 + Math.max(this.height(node.left), this.height(node.right));
    }
 
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        BST bst = new BST();
        while (sc.hasNext()) {
            bst.insert(sc.nextInt());
        }
        System.out.println("In Order Traversal:");
        bst.inOrderTraversal();
        System.out.println("\nPre Order Traversal:");
        bst.preOrderTraversal();
        System.out.println("\nHeight of the tree: " + bst.height());
    }
}
 
class Node {
    int key;
    Node left;
    Node right;
 
    public Node(int item) {
        this.key = item;
        this.left = this.right = null;
    }
}
