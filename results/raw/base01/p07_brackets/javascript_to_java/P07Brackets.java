package results.raw.base01.p07_brackets.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Stack;

public class P07Brackets {
    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            int n = Integer.parseInt(reader.readLine());
            Stack<Character> stack = new Stack<>();
            String[] lines = new String[n];
            for (int i = 0; i < n; i++) {
                lines[i] = reader.readLine();
            }

            for (String line : lines) {
                boolean isBalanced = true;
                for (char ch : line.toCharArray()) {
                    if ("([{".indexOf(ch) != -1) {
                        stack.push(ch);
                    } else if (stack.isEmpty() || stack.pop() != getMatchingPair(ch)) {
                        isBalanced = false;
                        break;
                    }
                }
                System.out.println(isBalanced && stack.isEmpty() ? "yes" : "no");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static char getMatchingPair(char ch) {
        switch (ch) {
            case ')':
                return '(';
            case ']':
                return '[';
            case '}':
                return '{';
            default:
                throw new IllegalArgumentException("Invalid character: " + ch);
        }
    }
}
