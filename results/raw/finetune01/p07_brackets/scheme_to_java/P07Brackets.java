import java.util.*;
 
public class Brackets {
    public static boolean isBalanced(String s) {
        Stack<Character> stack = new Stack<>();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '(' || c == '[' || c == '{') {
                stack.push(c);
            } else if (c == ')' || c == ']' || c == '}') {
                if (stack.isEmpty()) return false;
                char o = stack.pop();
                if (o != '(' && c == ')') return false;
                if (o != '[' && c == ']') return false;
                if (o != '{' && c == '}') return false;
            }
        }
        return stack.isEmpty();
    }
 
    public static void main(String[] args) {
        System.out.println(isBalanced("([]{})"));
        System.out.println(isBalanced("[({})](]"));
    }
}
