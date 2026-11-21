package results.raw.base01.p06_calc.haskell_to_java;

import java.util.Scanner;
import java.util.Arrays;

public class P06Calc {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        int result = parseExpression(tokens(line));
        System.out.println(result);
        scanner.close();
    }

    private static String[] tokens(String input) {
        return Arrays.stream(input.split("(?<= )|(?= )"))
                     .filter(s -> !s.trim().isEmpty())
                     .toArray(String[]::new);
    }

    private static int parseExpression(String[] tokens) {
        int[] result = parseTerm(tokens);
        while (result[1].length > 0) {
            String op = result[1][0];
            if (op.equals("+") || op.equals("-")) {
                int[] nextResult = parseTerm(Arrays.copyOfRange(result[1], 1, result[1].length));
                result[0] = op.equals("+") ? result[0] + nextResult[0] : result[0] - nextResult[0];
                result[1] = Arrays.copyOfRange(nextResult[1], 1, nextResult[1].length);
            } else {
                break;
            }
        }
        return result[0];
    }

    private static int[] parseTerm(String[] tokens) {
        int[] result = parseFactor(tokens);
        while (result[1].length > 0 && result[1][0].equals("*")) {
            int[] nextResult = parseFactor(Arrays.copyOfRange(result[1], 1, result[1].length));
            result[0] *= nextResult[0];
            result[1] = Arrays.copyOfRange(nextResult[1], 1, nextResult[1].length);
        }
        return result;
    }

    private static int[] parseFactor(String[] tokens) {
        if (tokens[0].equals("(")) {
            int[] result = parseExpression(Arrays.copyOfRange(tokens, 1, tokens.length));
            if (!tokens[result[1].length].equals(")")) {
                throw new IllegalArgumentException("Expected closing parenthesis");
            }
            return new int[]{result[0], Arrays.copyOfRange(result[1], 1, result[1].length)};
        } else {
            try {
                return new int[]{Integer.parseInt(tokens[0]), Arrays.copyOfRange(tokens, 1, tokens.length)};
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Invalid number format");
            }
        }
    }
}
