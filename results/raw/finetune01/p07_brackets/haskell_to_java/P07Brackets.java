import java.util.*;
 
public class Brackets {
    public static boolean isBalanced(String s) {
        Stack<Character> stack = new Stack<>();
        for (char c : s.toCharArray()) {
            switch (c) {
                case ')':
                    if (stack.isEmpty() || stack.pop() != '(') return false;
                    break;
                case ']':
                    if (stack.isEmpty() || stack.pop() != '[') return false;
                    break;
                case '}':
                    if (stack.isEmpty() || stack.pop() != '{') return false;
                    break;
                default:
                    stack.push(c);
            }
        }
        return stack.isEmpty();
    }
 
    public static void main(String[] args) {
        System.out.println(isBalanced("([]{})"));
        System.out.println(isBalanced("[({})](]"));
    }
}
