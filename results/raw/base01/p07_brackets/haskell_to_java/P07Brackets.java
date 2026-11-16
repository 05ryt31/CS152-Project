package results.raw.base01.p07_brackets.haskell_to_java;

import java.util.Scanner;
import java.io.PrintWriter;

public class P07Brackets {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        PrintWriter writer = new PrintWriter(System.out);

        int n = Integer.parseInt(scanner.nextLine());
        while (n-- > 0) {
            String line = scanner.nextLine();
            writer.println(balanced(line) ? "yes" : "no");
        }

        writer.flush();
    }

    private static boolean balanced(String text) {
        return valid(text, new StringBuilder());
    }

    private static boolean valid(String text, StringBuilder stack) {
        for (char c : text.toCharArray()) {
            if ("([{".indexOf(c) != -1) {
                stack.append(c);
            } else if (stack.length() == 0 || !matching(stack.charAt(stack.length() - 1), c)) {
                return false;
            } else {
                stack.setLength(stack.length() - 1);
            }
        }
        return stack.length() == 0;
    }

    private static boolean matching(char open, char close) {
        return (open == '(' && close == ')') ||
               (open == '[' && close == ']') ||
               (open == '{' && close == '}');
    }
}
