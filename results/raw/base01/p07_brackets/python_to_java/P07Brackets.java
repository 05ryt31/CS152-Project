package results.raw.base01.p07_brackets.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class P07Brackets {
    private static final String[] PAIRS = {"(", ")", "[", "]", "{", "}"};

    public static boolean balanced(String text) {
        Stack<Character> stack = new Stack<>();
        for (char ch : text.toCharArray()) {
            if ("([{".indexOf(ch) >= 0) {
                stack.push(ch);
            } else {
                if (stack.isEmpty() || stack.peek() != PAIRS[Arrays.asList(PAIRS).indexOf(ch) - 1]) {
                    return false;
                }
                stack.pop();
            }
        }
        return stack.isEmpty();
    }

    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int n = Integer.parseInt(reader.readLine());
        for (int i = 0; i < n; i++) {
            String line = reader.readLine().trim();
            if (balanced(line)) {
                System.out.println("yes");
            } else {
                System.out.println("no");
            }
        }
    }
}
