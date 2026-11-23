import java.util.*;
 
public class ExprTree {
 
    public static void main(String[] args) {
        String[] tokens = {"(", "a", "+", "b", "*", "c", ")", "/", "d"};
        Stack<Node> stack = new Stack<>();
        for (String token : tokens) {
            if (token.equals("+") || token.equals("-") || token.equals("*") || token.equals("/")) {
                Node right = stack.pop();
                Node left = stack.pop();
                stack.push(new Node(token, left, right));
            } else {
                stack.push(new Node(token));
            }
        }
        System.out.println(stack.pop());
    }
 
    private static class Node {
        private final String value;
        private final Node left;
        private final Node right;
 
        public Node(String value) {
            this.value = value;
            this.left = null;
            this.right = null;
        }
 
        public Node(String value, Node left, Node right) {
            this.value = value;
            this.left = left;
            this.right = right;
        }
 
        @Override
        public String toString() {
            StringBuilder sb = new StringBuilder();
            if (left != null && right != null) {
                sb.append("(");
                sb.append(left.toString());
                sb.append(" ");
                sb.append(value);
                sb.append(" ");
                sb.append(right.toString());
                sb.append(")");
            } else {
                sb.append(value);
            }
            return sb.toString();
        }
    }
}
