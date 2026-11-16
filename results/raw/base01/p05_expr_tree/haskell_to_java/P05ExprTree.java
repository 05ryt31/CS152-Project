package results.raw.base01.p05_expr_tree.haskell_to_java;

import java.util.*;

public class P05ExprTree {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        System.out.println(render(buildTree(line)));
    }

    private static Tree buildTree(String line) {
        return head(foldl(step, new ArrayList<>(), Arrays.asList(line.split(" "))));
    }

    private static List<Tree> foldl(Function<List<Tree>, String, List<Tree>> f, List<Tree> acc, List<String> list) {
        if (list.isEmpty()) {
            return acc;
        }
        return foldl(f, f.apply(acc, list.get(0)), list.subList(1, list.size()));
    }

    private static List<Tree> step(List<Tree> stack, String token) {
        if (!stack.isEmpty() && stack.size() >= 2 && "+-*/".contains(token)) {
            Tree right = stack.remove(stack.size() - 1);
            Tree left = stack.remove(stack.size() - 1);
            return Collections.singletonList(new Op(token, left, right));
        } else {
            return Collections.singletonList(new Leaf(token));
        }
    }

    private static Tree head(List<Tree> list) {
        return list.get(0);
    }

    private static String render(Tree tree) {
        if (tree instanceof Leaf) {
            return ((Leaf) tree).value;
        } else {
            Op op = (Op) tree;
            return "(" + render(op.left) + " " + op.op + " " + render(op.right) + ")";
        }
    }

    private static class Tree {
        String value;
        Tree left;
        Tree right;

        Tree(String value) {
            this.value = value;
        }

        Tree(String op, Tree left, Tree right) {
            this.op = op;
            this.left = left;
            this.right = right;
        }

        String op;
    }
}
