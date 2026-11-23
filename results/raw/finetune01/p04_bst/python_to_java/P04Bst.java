 
import java.util.ArrayList;
import java.util.List;
 
public class Tree {
 
    private Node root;
 
    public Tree() {
        this.root = null;
    }
 
    public boolean isEmpty() {
        return this.root == null;
    }
 
    public void insert(int key) {
        this.root = insert(this.root, key);
    }
 
    private Node insert(Node node, int key) {
        if (node == null) {
            node = new Node(key);
            return node;
        } else if (key < node.getKey()) {
            node.setLeft(insert(node.getLeft(), key));
        } else if (key > node.getKey()) {
            node.setRight(insert(node.getRight(), key));
        }
        return node;
    }
 
    public List<Integer> getInOrderTraversal() {
        List<Integer> list = new ArrayList<>();
        inOrderTraverse(this.root, list);
        return list;
    }
 
    private void inOrderTraverse(Node node, List<Integer> list) {
        if (node != null) {
            inOrderTraverse(node.getLeft(), list);
            list.add(node.getKey());
            inOrderTraverse(node.getRight(), list);
        }
    }
 
    public List<Integer> getPreOrderTraversal() {
        List<Integer> list = new ArrayList<>();
        preOrderTraverse(this.root, list);
        return list;
    }
 
    private void preOrderTraverse(Node node, List<Integer> list) {
        if (node != null) {
            list.add(node.getKey());
            preOrderTraverse(node.getLeft(), list);
            preOrderTraverse(node.getRight(), list);
        }
    }
 
    public int getHeight() {
        return getHeight(this.root);
    }
 
    private int getHeight(Node node) {
        if (node == null) {
            return 0;
        } else {
            return 1 + Math.max(getHeight(node.getLeft()), getHeight(node.getRight()));
        }
    }
 
    public static void main(String[] args) {
        Tree tree = new Tree();
        String[] tokens = "3 1 4 1 5 9 2 6 5 3 5".split("\\s+");
        for (String token : tokens) {
            tree.insert(Integer.parseInt(token));
        }
        System.out.println(tree.getInOrderTraversal());
        System.out.println(tree.getPreOrderTraversal());
        System.out.println(tree.getHeight());
    }
}
 
class Node {
 
    private int key;
    private Node left;
    private Node right;
 
    public Node(int key) {
        this.key = key;
        this.left = null;
        this.right = null;
    }
 
    public int getKey() {
        return this.key;
    }
 
    public void setKey(int key) {
        this.key = key;
    }
 
    public Node getLeft() {
        return this.left;
    }
 
    public void setLeft(Node left) {
        this.left = left;
    }
 
    public Node getRight() {
        return this.right;
    }
 
    public void setRight(Node right) {
        this.right = right;
    }
}
 
