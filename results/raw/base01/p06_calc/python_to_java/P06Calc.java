package results.raw.base01.p06_calc.python_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class P06Calc {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String text = reader.readLine();
        List<String> tokens = tokenize(text);
        Parser parser = new Parser(tokens);
        System.out.println(parser.expression());
    }

    private static List<String> tokenize(String text) {
        List<String> tokens = new ArrayList<>();
        int i = 0;
        while (i < text.length()) {
            char ch = text.charAt(i);
            if (ch == ' ') {
                i++;
            } else if (Character.isDigit(ch)) {
                int j = i;
                while (j < text.length() && Character.isDigit(text.charAt(j))) {
                    j++;
                }
                tokens.add(text.substring(i, j));
                i = j;
            } else {
                tokens.add(String.valueOf(ch));
                i++;
            }
        }
        return tokens;
    }

    private static class Parser {
        private final List<String> tokens;
        private int pos;

        public Parser(List<String> tokens) {
            this.tokens = tokens;
            this.pos = 0;
        }

        private String peek() {
            if (pos < tokens.size()) {
                return tokens.get(pos);
            }
            return null;
        }

        private String next() {
            String token = tokens.get(pos);
            pos++;
            return token;
        }

        private int expression() {
            int value = term();
            while (peek().equals("+") || peek().equals("-")) {
                String op = next();
                int right = term();
                if (op.equals("+")) {
                    value += right;
                } else {
                    value -= right;
                }
            }
            return value;
        }

        private int term() {
            int value = factor();
            while (peek().equals("*")) {
                next();
                value *= factor();
            }
            return value;
        }

        private int factor() {
            String token = next();
            if (token.equals("(")) {
                int value = expression();
                next();
                return value;
            }
            return Integer.parseInt(token);
        }
    }
}
