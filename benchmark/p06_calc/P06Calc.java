package benchmark.p06_calc;

import java.io.*;
import java.util.*;

public class P06Calc {
    static class Parser {
        List<String> tokens = new ArrayList<>();
        int pos;

        Parser(String text) {
            for (int i = 0; i < text.length();) {
                char c = text.charAt(i);
                if (Character.isWhitespace(c)) i++;
                else if (Character.isDigit(c)) {
                    int j = i;
                    while (j < text.length() && Character.isDigit(text.charAt(j))) j++;
                    tokens.add(text.substring(i, j)); 
                    i = j;
                } else {
                    tokens.add(String.valueOf(c)); 
                    i++; 
                }
            }
        }

        String peek() { return pos < tokens.size() ? tokens.get(pos) : null; }
        String next() { 
            String token = tokens.get(pos);
            pos++;
            return token; 
        }

        int expression() {
            int value = term();
            while ("+".equals(peek()) || "-".equals(peek())) {
                String op = next(); 
                int right = term();
                value = op.equals("+") ? value + right : value - right;
            }
            return value;
        }

        int term() {
            int value = factor();
            while ("*".equals(peek())) { 
                next(); 
                value *= factor(); 
            }
            return value;
        }
        
        int factor() {
            String token = next();
            if (token.equals("(")) { 
                int value = expression(); 
                next(); 
                return value; 
            }
            return Integer.parseInt(token);
        }
    }

    public static void main(String[] args) throws Exception {
        String text = new BufferedReader(new InputStreamReader(System.in)).readLine();
        System.out.println(new Parser(text).expression());
    }
}
