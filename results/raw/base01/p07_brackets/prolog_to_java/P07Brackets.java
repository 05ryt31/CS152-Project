package results.raw.base01.p07_brackets.prolog_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Scanner;

public class P07Brackets {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new BufferedReader(new InputStreamReader(System.in)))) {
            int n = Integer.parseInt(scanner.nextLine());
            while (n-- > 0) {
                String line = scanner.nextLine();
                if (isBalanced(line)) {
                    System.out.println("yes");
                } else {
                    System.out.println("no");
                }
            }
        }
    }

    private static boolean isBalanced(String line) {
        char[] chars = line.toCharArray();
        return isBalancedChars(chars, new char[0]);
    }

    private static boolean isBalancedChars(char[] chars, char[] stack) {
        if (chars.length == 0) {
            return stack.length == 0;
        }
        char c = chars[0];
        if (c == '(' || c == '[' || c == '{') {
            return isBalancedChars(Arrays.copyOfRange(chars, 1, chars.length), addChar(stack, c));
        } else {
            if (stack.length == 0 || !matches(stack[stack.length - 1], c)) {
                return false;
            }
            return isBalancedChars(Arrays.copyOfRange(chars, 1, chars.length), removeLastChar(stack));
        }
    }

    private static char[] addChar(char[] array, char c) {
        char[] newArray = Arrays.copyOf(array, array.length + 1);
        newArray[newArray.length - 1] = c;
        return newArray;
    }

    private static char[] removeLastChar(char[] array) {
        return Arrays.copyOf(array, array.length - 1);
    }

    private static boolean matches(char open, char close) {
        return (open == '(' && close == ')') ||
               (open == '[' && close == ']') ||
               (open == '{' && close == '}');
    }
}
