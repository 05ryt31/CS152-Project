import java.util.*;
 
public class Brackets {
    public static boolean checkBalance(String s){
        Stack<Character> stack = new Stack<>();
        for(char c : s.toCharArray()){
            if(c == '(' || c == '[' || c == '{'){
                stack.push(c);
            }else{
                if(stack.isEmpty()) return false;
                char last = stack.pop();
                if((c == ')' && last != '(') ||
                   (c == ']' && last != '[') ||
                   (c == '}' && last != '{')){
                    return false;
                }
            }
        }
        return stack.isEmpty();
    }
 
    public static void main(String[] args){
        System.out.println(checkBalance("()")); //true
        System.out.println(checkBalance("([]{})")); //true
        System.out.println(checkBalance("(]")); //false
        System.out.println(checkBalance("{[]}")); //true
        System.out.println(checkBalance("[({})](]")); //false
    }
}
