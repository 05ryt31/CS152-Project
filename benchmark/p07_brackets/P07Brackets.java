package benchmark.p07_brackets;

import java.io.*;
import java.util.*;

public class P07Brackets {
    static boolean balanced(String text) {
        if (text == null) return true;
        Deque<Character> stack = new ArrayDeque<>();
        for (char c : text.toCharArray()) {
            if (c == '(' || c == '[' || c == '{') stack.push(c);
            else {
                if (stack.isEmpty() || (c == ')' && stack.peek() != '(') ||
                    (c == ']' && stack.peek() != '[') || (c == '}' && stack.peek() != '{')) return false;
                stack.pop();
            }
        }
        return stack.isEmpty();
    }

    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int n = Integer.parseInt(reader.readLine());
        for (int i = 0; i < n; i++) {
            String line = reader.readLine();
            System.out.println(balanced(line) ? "yes" : "no");
        }
    }
}
