package results.raw.base01.p06_calc.javascript_to_java;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.regex.Pattern;

public class P06Calc {
    public static void main(String[] args) throws Exception {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String line = reader.readLine();
        String[] tokens = Pattern.compile("\\d+|[()+*-]").split(line);
        int position = 0;

        System.out.println(expression(tokens));
    }

    private static double factor(String[] tokens) {
        String token = tokens[position++];
        if (token.equals("(")) {
            return expression(tokens);
        }
        return Double.parseDouble(token);
    }

    private static double term(String[] tokens) {
        double value = factor(tokens);
        while (position < tokens.length && tokens[position].equals("*")) {
            position++;
            value *= factor(tokens);
        }
        return value;
    }

    private static double expression(String[] tokens) {
        double value = term(tokens);
        while (position < tokens.length && (tokens[position].equals("+") || tokens[position].equals("-"))) {
            String op = tokens[position++];
            double right = term(tokens);
            value = op.equals("+") ? value + right : value - right;
        }
        return value;
    }
}
