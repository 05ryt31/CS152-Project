import java.util.*;
 
public class BST {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        String[] nums = sc.nextLine().split(" ");
        int[] numArray = new int[nums.length];
        for(int i=0;i<nums.length;i++)
            numArray[i] = Integer.parseInt(nums[i]);
        Node root = null;
        for(int n:numArray)
            root = insert(root,n);
        System.out.println("In Order:");
        inOrder(root);
        System.out.println("\nPre Order:");
        preOrder(root);
        System.out.println("\nHeight of tree: " + height(root));
    }
 
    private static Node insert(Node root,int val){
        if(root == null)
            return new Node(val);
        if(val < root.val)
            root.left = insert(root.left,val);
        else
            root.right = insert(root.right,val);
        return root;
    }
 
    private static void inOrder(Node root){
        if(root != null){
            inOrder(root.left);
            System.out.print(root.val+" ");
            inOrder(root.right);
        }
    }
 
    private static void preOrder(Node root){
        if(root != null){
            System.out.print(root.val+" ");
            preOrder(root.left);
            preOrder(root.right);
        }
    }
 
    private static int height(Node root){
        if(root == null)
            return 0;
        return 1+Math.max(height(root.left),height(root.right));
    }
}
 
class Node{
    int val;
    Node left,right;
    Node(int v){val=v;}
}
