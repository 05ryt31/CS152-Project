package results.raw.base01.p06_calc.scheme_to_java;

import java.util.Scanner;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;

public class P06Calc {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(System.in)) {
            String input = scanner.nextLine();
            int result = calc(input);
            System.out.println(result);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static int calc(String str) {
        return parseExpr(tokenize(str));
    }

    private static int parseExpr(java.util.List<Object> tokens) {
        int res = parseTerm(tokens);
        while (!tokens.isEmpty() && (tokens.get(0).equals("+") || tokens.get(0).equals("-"))) {
            if (tokens.get(0).equals("+")) {
                tokens.remove(0);
                res += parseTerm(tokens);
            } else {
                tokens.remove(0);
                res -= parseTerm(tokens);
            }
        }
        return res;
    }

    private static int parseTerm(java.util.List<Object> tokens) {
        int res = parseFactor(tokens);
        while (!tokens.isEmpty() && tokens.get(0).equals("*")) {
            tokens.remove(0);
            res *= parseFactor(tokens);
        }
        return res;
    }

    private static int parseFactor(java.util.List<Object> tokens) {
        if (tokens.get(0) instanceof Integer) {
            return (Integer) tokens.remove(0);
        } else {
            int res = parseExpr((java.util.List<Object>) tokens.remove(0));
            tokens.remove(0); // Remove the closing parenthesis
            return res;
        }
    }

    private static java.util.List<Object> tokenize(String str) {
        java.util.List<Object> tokens = new java.util.ArrayList<>();
        java.util.List<Character> cs = new java.util.ArrayList<>();
        for (char c : str.toCharArray()) {
            cs.add(c);
        }
        while (!cs.isEmpty()) {
            char c = cs.remove(0);
            if (Character.isWhitespace(c)) {
                continue;
            } else if (Character.isDigit(c)) {
                StringBuilder sb = new StringBuilder();
                while (!cs.isEmpty() && Character.isDigit(cs.get(0))) {
                    sb.append(cs.remove(0));
                }
                tokens.add(Integer.parseInt(sb.toString()));
            } else {
                tokens.add(c);
            }
        }
        return tokens;
    }
}
