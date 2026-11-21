package results.raw.base01.p05_expr_tree.scheme_to_java;

import java.util.*;

public class P05ExprTree {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String input = scanner.nextLine();
        List<String> tokens = Arrays.asList(input.split("\\s+"));
        Object tree = build(tokens);
        System.out.println(render(tree));
    }

    private static Object build(List<String> tokens) {
        Deque<Object> stack = new ArrayDeque<>();
        for (String token : tokens) {
            if ("+".equals(token) || "-".equals(token) || "*".equals(token)) {
                Object right = stack.pop();
                Object left = stack.pop();
                stack.push(new ArrayList<>(List.of(token, left, right)));
            } else {
                stack.push(token);
            }
        }
        return stack.pop();
    }

    private static String render(Object tree) {
        if (tree instanceof String) {
            return (String) tree;
        } else {
            List<?> list = (List<?>) tree;
            return "(" + render(list.get(1)) + " " + list.get(0) + " " + render(list.get(2)) + ")";
        }
    }
}
