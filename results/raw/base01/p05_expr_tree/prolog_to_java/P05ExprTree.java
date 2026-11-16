package results.raw.base01.p05_expr_tree.prolog_to_java;

import java.util.*;
import java.io.*;

public class P05ExprTree {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        List<String> tokens = Arrays.asList(line.split(" "));
        List<Object> stack = new ArrayList<>();
        build(tokens, stack, stack);
        Object tree = stack.get(0);
        System.out.println(render(tree));
        System.exit(0);
    }

    private static void build(List<String> tokens, List<Object> stack, List<Object> result) {
        if (tokens.isEmpty()) {
            result.addAll(stack);
        } else {
            String token = tokens.get(0);
            tokens.remove(0);
            if ("+".equals(token) || "-".equals(token) || "*".equals(token)) {
                Object right = stack.remove(0);
                Object left = stack.remove(0);
                stack.add(new Op(token, left, right));
                build(tokens, stack, result);
            } else {
                stack.add(new Leaf(token));
                build(tokens, stack, result);
            }
        }
    }

    private static String render(Object tree) {
        if (tree instanceof Leaf) {
            return ((Leaf) tree).text;
        } else {
            Op op = (Op) tree;
            String left = render(op.left);
            String right = render(op.right);
            return "(" + left + " " + op.op + " " + right + ")";
        }
    }

    private static class Op {
        String op;
        Object left;
        Object right;

        Op(String op, Object left, Object right) {
            this.op = op;
            this.left = left;
            this.right = right;
        }
    }

    private static class Leaf {
        String text;

        Leaf(String text) {
            this.text = text;
        }
    }
}
