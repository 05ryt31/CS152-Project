package results.raw.base01.p07_brackets.scheme_to_java;

import java.util.Scanner;
import java.io.PrintWriter;

public class P07Brackets {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        PrintWriter writer = new PrintWriter(System.out);

        int n = Integer.parseInt(scanner.nextLine());
        for (int i = 0; i < n; i++) {
            String text = scanner.nextLine();
            if (isBalanced(text)) {
                writer.println("yes");
            } else {
                writer.println("no");
            }
        }

        writer.flush();
    }

    private static boolean isBalanced(String text) {
        char[] chars = text.toCharArray();
        java.util.Deque<Character> stack = new java.util.ArrayDeque<>();

        for (char c : chars) {
            if (c == '(' || c == '[' || c == '{') {
                stack.push(c);
            } else if (c == ')' || c == ']' || c == '}') {
                if (stack.isEmpty()) {
                    return false;
                }
                char opening = stack.pop();
                if (!matching(opening, c)) {
                    return false;
                }
            }
        }

        return stack.isEmpty();
    }

    private static boolean matching(char opener, char closer) {
        return (opener == '(' && closer == ')')
                || (opener == '[' && closer == ']')
                || (opener == '{' && closer == '}');
    }
}
